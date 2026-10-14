import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as img;
import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/evidence_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04d-m4-capture.md, group A (decisions M4-3 to M4-12, M4-15):
// commit → upload → finalize, the checks and the badge, coverage, retract.
// AC-3 cases are marked ★.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final coFunderId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );
  final viewerId = UuidValue.fromString('00000000-0000-4000-8000-000000000004');
  final otherManagerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000006',
  );
  final strangerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000005',
  );

  // The plot in Bafoussam; about 0.000899° of latitude per 100 m.
  const siteLat = 5.4778;
  const siteLng = 10.4176;
  const degreesPer100M = 0.000899;

  // A real JPEG, so the thumbnail is made from an actual photo.
  final photo = Uint8List.fromList(
    img.encodeJpg(img.Image(width: 640, height: 480), quality: 80),
  );
  final photoHash = sha256.convert(photo).toString();

  withServerpod('Given an active project with a validated site and a stage', (
    sessionBuilder,
    endpoints,
  ) {
    late int projectId;
    late StageView stage;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    final asOwner = signedInAs(ownerId);
    final asManager = signedInAs(managerId);

    EvidenceCommit commitFor({
      int? itemId,
      int? stageId,
      double? lat = siteLat,
      double? lng = siteLng,
      double? accuracyM = 8,
      bool? isMock = false,
      String? hash,
      DateTime? deviceCapturedAt,
      String? caption,
    }) => EvidenceCommit(
      stageId: stageId ?? stage.stage.id!,
      checklistItemId: itemId ?? stage.items.first.id!,
      sha256: hash ?? photoHash,
      deviceCapturedAt: deviceCapturedAt ?? DateTime.now().toUtc(),
      lat: lat,
      lng: lng,
      accuracyM: accuracyM,
      altitudeM: 700,
      isMockLocation: isMock,
      capturedInApp: true,
      deviceModel: 'Pixel 7',
      osVersion: 'Android 15',
      appVersion: '1.0.0',
      caption: caption,
    );

    /// What the phone's upload does, through the storage directly.
    Future<void> upload(int evidenceId, Uint8List bytes) =>
        sessionBuilder.build().storage.storeFile(
          storageId: 'private',
          path: 'projects/$projectId/evidence/$evidenceId/photo.jpg',
          byteData: ByteData.sublistView(bytes),
        );

    /// Commit, upload and finalize, as the phone does.
    Future<Evidence> capture({
      EvidenceCommit? commit,
      Uint8List? bytes,
      TestSessionBuilder? by,
    }) async {
      final result = await endpoints.evidence.commit(
        by ?? asManager,
        projectId,
        commit ?? commitFor(),
      );
      await upload(result.evidence.id!, bytes ?? photo);
      return endpoints.evidence.finalize(
        by ?? asManager,
        projectId,
        result.evidence.id!,
      );
    }

    Future<int> countAudit(String action) => AuditLog.db.count(
      sessionBuilder.build(),
      where: (t) => t.action.equals(action),
    );

    setUp(() async {
      projectId = (await endpoints.project.create(
        asOwner,
        ProjectDetails(
          name: 'House in Bafoussam',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
        stages: [
          StageDraft(
            name: 'Foundation',
            budgetMinor: 0,
            items: [
              ChecklistItemDraft(label: 'Trenches', isRequired: true),
              ChecklistItemDraft(label: 'Corners', isRequired: true),
            ],
          ),
        ],
      )).project.id!;
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insert(sessionBuilder.build(), [
        for (final (userId, role) in [
          (managerId, ProjectRole.siteManager),
          (otherManagerId, ProjectRole.siteManager),
          (coFunderId, ProjectRole.coFunder),
          (viewerId, ProjectRole.viewer),
        ])
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            status: MemberStatus.active,
            joinedAt: now,
          ),
      ]);
      final proposal = await endpoints.site.propose(
        asManager,
        projectId,
        lat: siteLat,
        lng: siteLng,
        accuracyM: 5,
        isMocked: false,
      );
      await endpoints.site.validate(
        asOwner,
        projectId,
        proposal.id!,
        radiusM: 50,
      );
      stage = (await endpoints.stage.plan(asOwner, projectId)).stages.single;
    });

    group('when the site manager captures inside the site with good GPS', () {
      test('★ then the capture is verified and every check passes', () async {
        final evidence = await capture();

        expect(evidence.status, EvidenceStatus.finalized);
        expect(evidence.verificationLevel, VerificationLevel.verified);
        expect(evidence.checks, hasLength(8));
        expect(evidence.checks!.every((c) => c.passed), isTrue);
        expect(evidence.fileSizeBytes, photo.length);
        expect(evidence.distanceFromSiteM, closeTo(0, 1));
        expect(evidence.finalizedAt, isNotNull);
      });

      test('then the server keeps its own commit time', () async {
        final before = DateTime.now().toUtc();
        final result = await endpoints.evidence.commit(
          asManager,
          projectId,
          commitFor(deviceCapturedAt: DateTime.utc(2026, 1, 1)),
        );

        expect(result.evidence.status, EvidenceStatus.committed);
        expect(result.evidence.verificationLevel, VerificationLevel.pending);
        expect(
          result.evidence.serverCommittedAt.isBefore(before),
          isFalse,
        );
        expect(result.uploadDescription, isNotEmpty);
      });

      test(
        'then the stored photo is unchanged and a thumbnail exists',
        () async {
          final evidence = await capture();

          final stored = await endpoints.evidence.media(
            signedInAs(viewerId),
            projectId,
            evidence.id!,
            MediaVariant.photo,
          );
          final thumbnail = await endpoints.evidence.media(
            signedInAs(viewerId),
            projectId,
            evidence.id!,
            MediaVariant.thumbnail,
          );

          expect(_bytes(stored), photo);
          final decoded = img.decodeJpg(_bytes(thumbnail))!;
          expect(decoded.width, 400);
        },
      );

      // doc/04g step 10b: the large views fetched the ~1 MB original.
      test('then a large photo is shown at a display size of 1280 px, made '
          'once and then reused', () async {
        final large = Uint8List.fromList(
          img.encodeJpg(img.Image(width: 2400, height: 1800), quality: 95),
        );
        final evidence = await capture(bytes: large);
        Future<Uint8List> display() async => _bytes(
          await endpoints.evidence.media(
            signedInAs(viewerId),
            projectId,
            evidence.id!,
            MediaVariant.display,
          ),
        );

        final first = await display();
        final second = await display();

        expect(img.decodeJpg(first)!.width, 1280);
        expect(first.length, lessThan(large.length));
        expect(second, first);
        expect(
          await sessionBuilder.build().storage.fileExists(
            storageId: 'private',
            path: EvidenceService.displayPath(projectId, evidence.id!),
          ),
          isTrue,
        );
      });

      test('then the display size is made when the photo is taken, so the '
          'first view is fast', () async {
        final evidence = await capture();

        expect(
          await sessionBuilder.build().storage.fileExists(
            storageId: 'private',
            path: EvidenceService.displayPath(projectId, evidence.id!),
          ),
          isTrue,
        );
      });

      test('then a photo narrower than the display size is not enlarged', () async {
        final evidence = await capture();

        final display = await endpoints.evidence.media(
          signedInAs(viewerId),
          projectId,
          evidence.id!,
          MediaVariant.display,
        );

        expect(img.decodeJpg(_bytes(display))!.width, 640);
      });

      test('then the first capture starts the stage', () async {
        await capture();

        final view = await endpoints.stage.get(
          asOwner,
          projectId,
          stage.stage.id!,
        );
        expect(view.stage.status, StageStatus.inProgress);
        expect(view.stage.startedAt, isNotNull);
      });

      test('then its item is covered', () async {
        await capture();

        final view = await endpoints.stage.get(
          asOwner,
          projectId,
          stage.stage.id!,
        );
        expect(view.itemsCovered, 1);
      });

      test('then it is audited and announced', () async {
        await capture();

        expect(await countAudit('evidence.commit'), 1);
        expect(await countAudit('evidence.finalize'), 1);
        expect(
          await ActivityEvent.db.count(
            sessionBuilder.build(),
            where: (t) => t.type.equals(ActivityType.evidenceCaptured),
          ),
          1,
        );
      });

      test('then members list it and fetch it', () async {
        final evidence = await capture();

        final listed = await endpoints.evidence.list(
          signedInAs(coFunderId),
          projectId,
          stage.stage.id!,
        );
        final fetched = await endpoints.evidence.get(
          signedInAs(viewerId),
          projectId,
          evidence.id!,
        );

        expect(listed.map((e) => e.id), [evidence.id]);
        expect(fetched.verificationLevel, VerificationLevel.verified);
      });
    });

    test('★ when the photo is taken outside the radius then it is accepted '
        'but unverified, with the distance and the allowed distance', () async {
      final evidence = await capture(
        commit: commitFor(lat: siteLat + degreesPer100M * 2),
      );

      expect(evidence.status, EvidenceStatus.finalized);
      expect(evidence.verificationLevel, VerificationLevel.unverified);
      final inside = evidence.checks!.singleWhere(
        (c) => c.name == VerificationCheckName.insideSite,
      );
      expect(inside.passed, isFalse);
      expect(int.parse(inside.details!['distanceM']!), closeTo(200, 2));
      expect(inside.details!['allowedM'], '58');
    });

    test('★ when the stored file differs from the committed hash then it is '
        'unverified with the hash check failed', () async {
      final tampered = Uint8List.fromList([...photo, 0]);

      final evidence = await capture(bytes: tampered);

      expect(evidence.verificationLevel, VerificationLevel.unverified);
      expect(
        evidence.checks!
            .singleWhere((c) => c.name == VerificationCheckName.hashMatch)
            .passed,
        isFalse,
      );
    });

    test(
      'when the GPS is poor then it is accepted and partially verified',
      () async {
        final evidence = await capture(commit: commitFor(accuracyM: 25.0 + 15));

        expect(evidence.verificationLevel, VerificationLevel.partiallyVerified);
      },
    );

    test(
      'when there is no GPS fix then it is accepted but unverified',
      () async {
        final evidence = await capture(
          commit: commitFor(lat: null, lng: null, accuracyM: null),
        );

        expect(evidence.status, EvidenceStatus.finalized);
        expect(evidence.verificationLevel, VerificationLevel.unverified);
      },
    );

    group('when the upload goes wrong', () {
      test('without the file then finalize throws uploadMissing', () async {
        final result = await endpoints.evidence.commit(
          asManager,
          projectId,
          commitFor(),
        );

        await expectLater(
          endpoints.evidence.finalize(
            asManager,
            projectId,
            result.evidence.id!,
          ),
          throwsA(_appException(AppErrorCode.uploadMissing)),
        );
      });

      test('a second finalize then throws evidenceNotCommitted', () async {
        final evidence = await capture();

        await expectLater(
          endpoints.evidence.finalize(asManager, projectId, evidence.id!),
          throwsA(_appException(AppErrorCode.evidenceNotCommitted)),
        );
      });

      test('with a file above 10 MB then finalize throws '
          'evidenceFileTooLarge', () async {
        final result = await endpoints.evidence.commit(
          asManager,
          projectId,
          commitFor(),
        );
        await upload(result.evidence.id!, Uint8List(10 * 1024 * 1024 + 1));

        await expectLater(
          endpoints.evidence.finalize(
            asManager,
            projectId,
            result.evidence.id!,
          ),
          throwsA(_appException(AppErrorCode.evidenceFileTooLarge)),
        );
      });

      test(
        'then a new upload description is issued while committed only',
        () async {
          final result = await endpoints.evidence.commit(
            asManager,
            projectId,
            commitFor(),
          );

          expect(
            await endpoints.evidence.uploadDescription(
              asManager,
              projectId,
              result.evidence.id!,
            ),
            isNotEmpty,
          );
          await upload(result.evidence.id!, photo);
          await endpoints.evidence.finalize(
            asManager,
            projectId,
            result.evidence.id!,
          );
          await expectLater(
            endpoints.evidence.uploadDescription(
              asManager,
              projectId,
              result.evidence.id!,
            ),
            throwsA(_appException(AppErrorCode.evidenceNotCommitted)),
          );
        },
      );

      test(
        'and nothing arrives for 24 h then it is listed as upload failed',
        () async {
          final result = await endpoints.evidence.commit(
            asManager,
            projectId,
            commitFor(),
          );
          final session = sessionBuilder.build();
          await Evidence.db.updateRow(
            session,
            result.evidence.copyWith(
              serverCommittedAt: DateTime.now().toUtc().subtract(
                const Duration(hours: 24, minutes: 1),
              ),
            ),
          );

          final listed = await endpoints.evidence.list(
            asOwner,
            projectId,
            stage.stage.id!,
          );

          expect(listed.single.status, EvidenceStatus.uploadFailed);
        },
      );
    });

    group('when the commit is not allowed', () {
      for (final (name, userId) in [
        ('the owner', ownerId),
        ('a co-funder', coFunderId),
        ('a viewer', viewerId),
      ]) {
        test('from $name then it throws permissionDenied', () async {
          await expectLater(
            endpoints.evidence.commit(
              signedInAs(userId),
              projectId,
              commitFor(),
            ),
            throwsA(_appException(AppErrorCode.permissionDenied)),
          );
        });
      }

      test('from a non-member then it throws projectNotFound', () async {
        await expectLater(
          endpoints.evidence.commit(
            signedInAs(strangerId),
            projectId,
            commitFor(),
          ),
          throwsA(_appException(AppErrorCode.projectNotFound)),
        );
      });

      test('on a paused project then it throws projectNotActive', () async {
        await endpoints.project.setStatus(
          asOwner,
          projectId,
          ProjectStatus.paused,
        );

        await expectLater(
          endpoints.evidence.commit(asManager, projectId, commitFor()),
          throwsA(_appException(AppErrorCode.projectNotActive)),
        );
      });

      test('on a submitted stage then it throws stageLocked', () async {
        final session = sessionBuilder.build();
        await Stage.db.updateRow(
          session,
          stage.stage.copyWith(status: StageStatus.submitted),
        );

        await expectLater(
          endpoints.evidence.commit(asManager, projectId, commitFor()),
          throwsA(_appException(AppErrorCode.stageLocked)),
        );
      });

      test('for an item of another stage then it throws '
          'checklistItemNotFound', () async {
        final other = await endpoints.stage.create(
          asOwner,
          projectId,
          StageDraft(
            name: 'Walls',
            budgetMinor: 0,
            items: [ChecklistItemDraft(label: 'Walls', isRequired: true)],
          ),
        );

        await expectLater(
          endpoints.evidence.commit(
            asManager,
            projectId,
            commitFor(itemId: other.items.single.id),
          ),
          throwsA(_appException(AppErrorCode.checklistItemNotFound)),
        );
      });

      for (final (what, commit) in <(String, EvidenceCommit Function())>[
        ('a hash that is not 64 hex characters', () => commitFor(hash: 'abc')),
        ('a latitude of 91', () => commitFor(lat: 91)),
        ('a caption of 501 characters', () => commitFor(caption: 'x' * 501)),
      ]) {
        test('with $what then it throws a matching error', () async {
          await expectLater(
            endpoints.evidence.commit(asManager, projectId, commit()),
            throwsA(isA<AppException>()),
          );
        });
      }
    });

    group('when a capture is retracted', () {
      test('by its author then it stays visible, retracted, and stops '
          'covering its item', () async {
        final evidence = await capture();

        final retracted = await endpoints.evidence.retract(
          asManager,
          projectId,
          evidence.id!,
          'Wrong corner',
        );
        final view = await endpoints.stage.get(
          asOwner,
          projectId,
          stage.stage.id!,
        );

        expect(retracted.status, EvidenceStatus.retracted);
        expect(retracted.retractedReason, 'Wrong corner');
        expect(retracted.verificationLevel, VerificationLevel.verified);
        expect(view.itemsCovered, 0);
        expect(await countAudit('evidence.retract'), 1);
      });

      test('by another site manager then it throws notYourCapture', () async {
        final evidence = await capture();

        await expectLater(
          endpoints.evidence.retract(
            signedInAs(otherManagerId),
            projectId,
            evidence.id!,
            'Not mine',
          ),
          throwsA(_appException(AppErrorCode.notYourCapture)),
        );
      });

      test('twice then it throws evidenceAlreadyRetracted', () async {
        final evidence = await capture();
        await endpoints.evidence.retract(
          asManager,
          projectId,
          evidence.id!,
          'Blurred',
        );

        await expectLater(
          endpoints.evidence.retract(
            asManager,
            projectId,
            evidence.id!,
            'Again',
          ),
          throwsA(_appException(AppErrorCode.evidenceAlreadyRetracted)),
        );
      });
    });

    test('when another site manager finalizes someone else\'s capture then it '
        'throws notYourCapture', () async {
      final result = await endpoints.evidence.commit(
        asManager,
        projectId,
        commitFor(),
      );
      await upload(result.evidence.id!, photo);

      await expectLater(
        endpoints.evidence.finalize(
          signedInAs(otherManagerId),
          projectId,
          result.evidence.id!,
        ),
        throwsA(_appException(AppErrorCode.notYourCapture)),
      );
    });

    test(
      'when a non-member asks for a photo then it throws projectNotFound',
      () async {
        final evidence = await capture();

        await expectLater(
          endpoints.evidence.media(
            signedInAs(strangerId),
            projectId,
            evidence.id!,
            MediaVariant.photo,
          ),
          throwsA(_appException(AppErrorCode.projectNotFound)),
        );
      },
    );

    // M4-15: a photo points to its checklist item.
    test('when the owner removes a checklist item that has a capture then it '
        'throws checklistItemHasEvidence', () async {
      await capture();

      await expectLater(
        endpoints.stage.update(
          asOwner,
          projectId,
          stage.stage.id!,
          StageDraft(
            name: 'Foundation',
            budgetMinor: 0,
            items: [
              ChecklistItemDraft(
                itemId: stage.items.last.id,
                label: 'Corners',
                isRequired: true,
              ),
            ],
          ),
        ),
        throwsA(_appException(AppErrorCode.checklistItemHasEvidence)),
      );
    });
  });
}

/// The bytes of [data], which may be a view into a larger buffer.
Uint8List _bytes(ByteData data) =>
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
