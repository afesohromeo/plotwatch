import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/geo_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

// Plan: doc/04b-m2-projects-site-members.md, group D (decisions M2-15 to
// M2-18): the site manager proposes the location from GPS on the plot, the
// owner validates it with a radius or rejects it.
void main() {
  final ownerId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');
  final managerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000002',
  );
  final coFunderId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000003',
  );
  final viewerId = UuidValue.fromString('00000000-0000-4000-8000-000000000004');
  final strangerId = UuidValue.fromString(
    '00000000-0000-4000-8000-000000000005',
  );

  // A plot in Bafoussam, Cameroon.
  const lat = 5.4778;
  const lng = 10.4176;

  withServerpod('Given a draft project with a site manager', (
    sessionBuilder,
    endpoints,
  ) {
    late int projectId;

    TestSessionBuilder signedInAs(UuidValue userId) => sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.uuid,
        {},
      ),
    );

    Future<SiteProposal> propose({
      double atLat = lat,
      double atLng = lng,
      double accuracyM = 8,
      bool isMocked = false,
      UuidValue? by,
    }) => endpoints.site.propose(
      signedInAs(by ?? managerId),
      projectId,
      lat: atLat,
      lng: atLng,
      accuracyM: accuracyM,
      isMocked: isMocked,
    );

    Future<Project> storedProject() async =>
        (await Project.db.findById(sessionBuilder.build(), projectId))!;

    setUp(() async {
      projectId = (await endpoints.project.create(
        signedInAs(ownerId),
        ProjectDetails(
          name: 'House in Bafoussam',
          type: ProjectType.newHouse,
          currencyCode: 'XAF',
        ),
      )).project.id!;
      final now = DateTime.now().toUtc();
      await ProjectMember.db.insert(sessionBuilder.build(), [
        for (final (userId, role) in [
          (managerId, ProjectRole.siteManager),
          (coFunderId, ProjectRole.coFunder),
          (viewerId, ProjectRole.viewer),
        ])
          ProjectMember(
            projectId: projectId,
            authUserId: userId,
            role: role,
            canApprove: role == ProjectRole.coFunder,
            status: MemberStatus.active,
            joinedAt: now,
          ),
      ]);
    });

    group('when the site manager proposes the location', () {
      test('then a pending proposal is saved, audited and announced', () async {
        final proposal = await propose();
        final session = sessionBuilder.build();

        expect(proposal.status, SiteProposalStatus.pending);
        expect(proposal.proposedBy, managerId);
        expect(proposal.lat, lat);
        expect(proposal.accuracyM, 8);
        expect(
          (await AuditLog.db.find(
            session,
            where: (t) => t.action.equals('site.propose'),
          )).single.after?['lat'],
          '$lat',
        );
        expect(
          (await ActivityEvent.db.find(
            session,
            where: (t) => t.type.equals(ActivityType.siteProposed),
          )).length,
          1,
        );
      });

      test('with an accuracy of exactly 20 m then it is accepted', () async {
        final proposal = await propose(accuracyM: 20);

        expect(proposal.status, SiteProposalStatus.pending);
      });

      test(
        'with an accuracy of 20.1 m then it throws siteAccuracyTooLow',
        () async {
          await expectLater(
            propose(accuracyM: 20.1),
            throwsA(_appException(AppErrorCode.siteAccuracyTooLow)),
          );
        },
      );

      test('from a mocked position then it throws siteMockLocation', () async {
        await expectLater(
          propose(isMocked: true),
          throwsA(_appException(AppErrorCode.siteMockLocation)),
        );
      });

      for (final (badLat, badLng) in [(90.5, lng), (lat, -180.5)]) {
        test(
          'at ($badLat, $badLng) then it throws invalidSiteLocation',
          () async {
            await expectLater(
              propose(atLat: badLat, atLng: badLng),
              throwsA(_appException(AppErrorCode.invalidSiteLocation)),
            );
          },
        );
      }

      test('a second time then the first proposal is superseded', () async {
        final first = await propose();

        await propose(atLat: lat + 0.0001);

        final stored = await SiteProposal.db.findById(
          sessionBuilder.build(),
          first.id!,
        );
        expect(stored!.status, SiteProposalStatus.superseded);
      });
    });

    // The owner on the plot localizes it too (doc/04b G-12).
    test('when the owner proposes the location then it is accepted, and the '
        'owner can validate it', () async {
      final proposal = await propose(by: ownerId);

      expect(proposal.proposedBy, ownerId);
      final site = await endpoints.site.validate(
        signedInAs(ownerId),
        projectId,
        proposal.id!,
        radiusM: 40,
      );
      expect(site.validatedBy, ownerId);
    });

    for (final (name, userId) in [
      ('a co-funder', coFunderId),
      ('a viewer', viewerId),
    ]) {
      test(
        'when $name proposes the location then it throws permissionDenied',
        () async {
          await expectLater(
            propose(by: userId),
            throwsA(_appException(AppErrorCode.permissionDenied)),
          );
        },
      );
    }

    test('when a non-member proposes the location then it throws '
        'projectNotFound', () async {
      await expectLater(
        propose(by: strangerId),
        throwsA(_appException(AppErrorCode.projectNotFound)),
      );
    });

    group('when the owner validates the first proposal', () {
      late SiteProposal proposal;

      setUp(() async => proposal = await propose());

      test('then the site exists and the project becomes active', () async {
        final site = await endpoints.site.validate(
          signedInAs(ownerId),
          projectId,
          proposal.id!,
          radiusM: 40,
          addressText: ' Behind the Total station ',
        );

        expect(site.centerLat, lat);
        expect(site.centerLng, lng);
        expect(site.radiusM, 40);
        expect(site.plusCode, GeoService.plusCodeFor(lat, lng));
        expect(site.addressText, 'Behind the Total station');
        expect(site.validatedProposalId, proposal.id);
        expect(site.validatedBy, ownerId);
        expect((await storedProject()).status, ProjectStatus.active);
        expect(
          await endpoints.site.get(signedInAs(managerId), projectId),
          isNotNull,
        );
        final stored = await SiteProposal.db.findById(
          sessionBuilder.build(),
          proposal.id!,
        );
        expect(stored!.status, SiteProposalStatus.validated);
        expect(stored.decidedBy, ownerId);
      });

      test('then the change is audited and announced as siteChanged', () async {
        await endpoints.site.validate(
          signedInAs(ownerId),
          projectId,
          proposal.id!,
          radiusM: 50,
        );
        final session = sessionBuilder.build();

        final audit = await AuditLog.db.findFirstRow(
          session,
          where: (t) => t.action.equals('site.validate'),
        );
        expect(audit!.before, isNull);
        expect(audit.after?['radiusM'], '50');
        final events = await ActivityEvent.db.find(
          session,
          where: (t) => t.type.equals(ActivityType.siteChanged),
        );
        expect(events, hasLength(1));
      });

      for (final radius in [9, 501]) {
        test(
          'with a radius of $radius m then it throws invalidSiteRadius',
          () async {
            await expectLater(
              endpoints.site.validate(
                signedInAs(ownerId),
                projectId,
                proposal.id!,
                radiusM: radius,
              ),
              throwsA(_appException(AppErrorCode.invalidSiteRadius)),
            );
          },
        );
      }

      test('as the site manager then it throws permissionDenied', () async {
        await expectLater(
          endpoints.site.validate(
            signedInAs(managerId),
            projectId,
            proposal.id!,
            radiusM: 50,
          ),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });

      test('of another project then it throws siteProposalNotFound', () async {
        final otherProject = (await endpoints.project.create(
          signedInAs(ownerId),
          ProjectDetails(
            name: 'Shop in Douala',
            type: ProjectType.other,
            currencyCode: 'XAF',
          ),
        )).project.id!;

        await expectLater(
          endpoints.site.validate(
            signedInAs(ownerId),
            otherProject,
            proposal.id!,
            radiusM: 50,
          ),
          throwsA(_appException(AppErrorCode.siteProposalNotFound)),
        );
      });
    });

    group('when the site has already been validated', () {
      setUp(() async {
        final first = await propose();
        await endpoints.site.validate(
          signedInAs(ownerId),
          projectId,
          first.id!,
          radiusM: 50,
        );
      });

      test(
        'then a new validated proposal moves it and keeps the status',
        () async {
          await endpoints.project.setStatus(
            signedInAs(ownerId),
            projectId,
            ProjectStatus.paused,
          );
          final second = await propose(atLat: lat + 0.001);

          final site = await endpoints.site.validate(
            signedInAs(ownerId),
            projectId,
            second.id!,
            radiusM: 30,
          );

          expect(site.centerLat, lat + 0.001);
          expect(site.radiusM, 30);
          expect(await Site.db.count(sessionBuilder.build()), 1);
          expect((await storedProject()).status, ProjectStatus.paused);
          final audit = await AuditLog.db.find(
            sessionBuilder.build(),
            where: (t) => t.action.equals('site.validate'),
            orderBy: (t) => t.id,
          );
          expect(audit.last.before?['lat'], '$lat');
        },
      );

      test('then the validated proposal cannot be validated again', () async {
        final validated = (await endpoints.site.listProposals(
          signedInAs(ownerId),
          projectId,
        )).single;

        await expectLater(
          endpoints.site.validate(
            signedInAs(ownerId),
            projectId,
            validated.id!,
            radiusM: 50,
          ),
          throwsA(_appException(AppErrorCode.siteProposalNotPending)),
        );
      });
    });

    group('when the owner rejects a proposal', () {
      late SiteProposal proposal;

      setUp(() async => proposal = await propose());

      test(
        'with a reason then it is rejected and the project stays a draft',
        () async {
          await endpoints.site.reject(
            signedInAs(ownerId),
            projectId,
            proposal.id!,
            reason: 'This is the neighbour\'s plot',
          );

          final stored = await SiteProposal.db.findById(
            sessionBuilder.build(),
            proposal.id!,
          );
          expect(stored!.status, SiteProposalStatus.rejected);
          expect(stored.rejectReason, 'This is the neighbour\'s plot');
          expect((await storedProject()).status, ProjectStatus.draft);
          expect(
            await endpoints.site.get(signedInAs(ownerId), projectId),
            isNull,
          );
          final events = await ActivityEvent.db.find(
            sessionBuilder.build(),
            where: (t) => t.type.equals(ActivityType.siteProposalRejected),
          );
          expect(events, hasLength(1));
        },
      );

      test('without a reason then it is rejected', () async {
        await endpoints.site.reject(
          signedInAs(ownerId),
          projectId,
          proposal.id!,
        );

        final stored = await SiteProposal.db.findById(
          sessionBuilder.build(),
          proposal.id!,
        );
        expect(stored!.status, SiteProposalStatus.rejected);
        expect(stored.rejectReason, isNull);
      });

      test(
        'with a reason of 501 characters then it throws textTooLong',
        () async {
          await expectLater(
            endpoints.site.reject(
              signedInAs(ownerId),
              projectId,
              proposal.id!,
              reason: 'x' * 501,
            ),
            throwsA(_appException(AppErrorCode.textTooLong)),
          );
        },
      );

      test(
        'that was superseded then it throws siteProposalNotPending',
        () async {
          await propose(atLat: lat + 0.0001);

          await expectLater(
            endpoints.site.reject(signedInAs(ownerId), projectId, proposal.id!),
            throwsA(_appException(AppErrorCode.siteProposalNotPending)),
          );
        },
      );

      test('as the site manager then it throws permissionDenied', () async {
        await expectLater(
          endpoints.site.reject(signedInAs(managerId), projectId, proposal.id!),
          throwsA(_appException(AppErrorCode.permissionDenied)),
        );
      });
    });

    // The project page shows the owner "review the location" and the site
    // manager "waiting for validation" (doc/04b group G).
    test('when a proposal is pending then the project overview carries it, '
        'and once validated it no longer does', () async {
      final proposal = await propose();

      final pending = await endpoints.project.get(
        signedInAs(ownerId),
        projectId,
      );
      expect(pending.pendingSiteProposal?.id, proposal.id);

      await endpoints.site.validate(
        signedInAs(ownerId),
        projectId,
        proposal.id!,
        radiusM: 50,
      );
      final validated = await endpoints.project.get(
        signedInAs(managerId),
        projectId,
      );
      expect(validated.pendingSiteProposal, isNull);
      expect(validated.site, isNotNull);
    });

    test('when the proposals are listed then the newest comes first', () async {
      final first = await propose();
      final second = await propose(atLat: lat + 0.0001);

      final proposals = await endpoints.site.listProposals(
        signedInAs(viewerId),
        projectId,
      );

      expect(proposals.map((p) => p.id), [second.id, first.id]);
    });
  });
}

Matcher _appException(AppErrorCode code) =>
    isA<AppException>().having((e) => e.code, 'code', code);
