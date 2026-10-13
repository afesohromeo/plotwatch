import 'dart:async';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../endpoints/ledger_endpoint.dart';
import '../endpoints/membership_endpoint.dart';
import '../endpoints/evidence_endpoint.dart';
import '../endpoints/progress_update_endpoint.dart';
import '../endpoints/project_endpoint.dart';
import '../endpoints/site_endpoint.dart';
import '../endpoints/stage_endpoint.dart';
import '../generated/protocol.dart';
import '../services/account_service.dart';

/// What a seed run did.
enum DemoSeedOutcome {
  /// The demo project was created (or an incomplete one replaced).
  created,

  /// The complete demo project was already there.
  alreadyThere,

  /// Another server is seeding it right now.
  busy,
}

/// A demo person: their sign-in, name and settings.
typedef DemoPerson = ({
  String email,
  String fullName,
  String locale,
  String countryCode,
});

/// The judges' demo project, "Afesoh Residence" (doc/04g step 7): a
/// 5-storey building in Odza, Yaoundé, six weeks into the build.
///
/// It is made by calling the real endpoints as each demo person, so every
/// permission, verification, feed entry and notification is the app's own.
/// The services stamp everything with "now", so after each step the
/// timestamps that step wrote are moved back to the day the story gives it
/// ([_backdate]); only the demo project's rows are touched.
class DemoSeed {
  DemoSeed({required this.photo, required this.receipt, DateTime? now})
    : _now = (now ?? DateTime.now()).toUtc();

  /// The site photo with this file name (`seed/photos/`).
  final Uint8List Function(String name) photo;

  /// The receipt image with this file name (`seed/receipts/`).
  final Uint8List Function(String name) receipt;

  final DateTime _now;

  static const projectName = 'Afesoh Residence';
  static const owner = (
    email: 'funder@demo.plotwatch.app',
    fullName: 'Brice Afesoh',
    locale: 'en',
    countryCode: 'CA',
  );
  static const manager = (
    email: 'manager@demo.plotwatch.app',
    fullName: 'Joseph Mvondo',
    locale: 'fr',
    countryCode: 'CM',
  );
  static const coFunder = (
    email: 'cofunder@demo.plotwatch.app',
    fullName: 'Mary Aelys',
    locale: 'fr',
    countryCode: 'FR',
  );

  /// The plot in Odza, Yaoundé.
  static const siteLat = 3.7921;
  static const siteLng = 11.5437;
  static const siteRadiusM = 50;

  static const _storageId = 'private';

  /// The files the story uses (`web/seed/photos/` and `web/seed/receipts/`).
  static const photoFiles = [
    'site_preparation_1.jpg',
    'site_preparation_2.jpg',
    'foundation_1.jpg',
    'foundation_2.jpg',
    'foundation_3.jpg',
    'ground_floor_1.jpg',
    'ground_floor_2.jpg',
    'ground_floor_3.jpg',
  ];
  static const receiptFiles = [
    'receipt_excavator.png',
    'receipt_cement.png',
    'receipt_rebar.png',
  ];

  /// Any number, the same for every server: only one seeds at a time.
  static const _lockKey = 74100251;

  /// Creates the demo accounts and project, unless it is already there or
  /// another server is seeding it right now.
  Future<DemoSeedOutcome> run(Session session, {required String password}) =>
      _withLock(session, () => _run(session, password: password));

  /// Runs [body] while this server holds a database lock, kept by a
  /// transaction left open meanwhile; [DemoSeedOutcome.busy] when another
  /// server holds it.
  Future<DemoSeedOutcome> _withLock(
    Session session,
    Future<DemoSeedOutcome> Function() body,
  ) async {
    final held = Completer<bool>();
    final release = Completer<void>();
    final lock = session.db.transaction((transaction) async {
      final rows = await session.db.unsafeQuery(
        'SELECT pg_try_advisory_xact_lock($_lockKey)',
        transaction: transaction,
      );
      held.complete(rows.isNotEmpty && rows.first.first == true);
      await release.future;
    });
    unawaited(
      lock.then<void>(
        (_) {},
        onError: (Object e, StackTrace s) {
          if (!held.isCompleted) held.completeError(e, s);
        },
      ),
    );
    try {
      if (!await held.future) return DemoSeedOutcome.busy;
      return await body();
    } finally {
      if (!release.isCompleted) release.complete();
      await lock.catchError((_) {});
    }
  }

  Future<DemoSeedOutcome> _run(
    Session session, {
    required String password,
  }) async {
    // Every file first: a missing one stops the seed before it writes.
    for (final file in photoFiles) {
      photo(file);
    }
    for (final file in receiptFiles) {
      receipt(file);
    }

    final ownerId = await _account(session, owner, password);
    final existing = await _find(session, ownerId);
    if (existing != null) {
      if (await _complete(session, existing.id!)) {
        return DemoSeedOutcome.alreadyThere;
      }
      // A seed that stopped halfway, before it cleaned up after itself.
      await const AccountService().deleteProject(session, existing.id!);
    }
    final managerId = await _account(session, manager, password);
    final coFunderId = await _account(session, coFunder, password);

    void as(UuidValue userId) => session.updateAuthenticated(
      AuthenticationInfo(userId.uuid, {}, authId: 'demo-seed'),
    );

    late int projectId;
    var made = false;
    Future<void> step(
      int daysAgo,
      int hour,
      Future<void> Function() body,
    ) async {
      final start = DateTime.now().toUtc();
      await body();
      final day = _now.subtract(Duration(days: daysAgo));
      final target = DateTime.utc(day.year, day.month, day.day, hour - 1);
      await _backdate(session, projectId, from: start, by: start.difference(target));
    }

    final projects = ProjectEndpoint();
    final membership = MembershipEndpoint();
    final sites = SiteEndpoint();
    final stages = StageEndpoint();
    final evidence = EvidenceEndpoint();
    final ledger = LedgerEndpoint();
    final updates = ProgressUpdateEndpoint();

    DateTime day(int daysAgo) => _now.subtract(Duration(days: daysAgo));
    late List<StageView> plan;
    int stageId(int index) => plan[index].stage.id!;
    int itemId(int stage, int item) => plan[stage].items[item].id!;

    try {
    // --- Six weeks ago: the plan, the people, the site.
    as(ownerId);
    final created = await projects.create(
      session,
      ProjectDetails(
        name: projectName,
        description:
            'A 5-storey residential building on a 500 m² plot in Odza, '
            'Yaoundé: ten flats over a ground floor of shops.',
        type: ProjectType.newHouse,
        currencyCode: 'XAF',
        plannedStart: _date(day(42)),
        plannedEnd: _date(day(-300)),
      ),
      stages: _plan(),
    );
    projectId = created.project.id!;
    made = true;
    await _backdate(
      session,
      projectId,
      from: created.project.createdAt.subtract(const Duration(seconds: 1)),
      by: DateTime.now().toUtc().difference(_at(42, 9)),
    );

    await step(42, 10, () async {
      for (final (userId, role, canApprove) in [
        (managerId, ProjectRole.siteManager, false),
        (coFunderId, ProjectRole.coFunder, true),
      ]) {
        as(ownerId);
        final invitation = await membership.createInvitation(
          session,
          projectId,
          role,
          canApprove: canApprove,
        );
        as(userId);
        await membership.acceptInvitation(session, invitation.code);
      }
    });

    await step(40, 9, () async {
      as(managerId);
      final proposal = await sites.propose(
        session,
        projectId,
        lat: siteLat,
        lng: siteLng,
        accuracyM: 5,
        isMocked: false,
      );
      as(ownerId);
      await sites.validate(
        session,
        projectId,
        proposal.id!,
        radiusM: siteRadiusM,
        addressText: 'Odza, Yaoundé, Cameroon',
      );
    });
    as(managerId);
    plan = (await stages.plan(session, projectId)).stages;

    // --- Site preparation: paid, done, approved.
    await step(39, 11, () async {
      await _release(
        session,
        ledger,
        as: () => as(ownerId),
        confirmAs: () => as(managerId),
        projectId: projectId,
        draft: ReleaseDraft(
          amountMinor: 4500000,
          occurredOn: day(39),
          method: ReleaseMethod.mobileMoney,
          reference: 'MOMO-58213907',
          stageId: stageId(0),
          note: 'Site preparation: clearing, setting out and excavation.',
        ),
      );
    });
    await step(37, 8, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(0),
        itemId(0, 0),
        'site_preparation_1.jpg',
      );
    });
    await step(36, 15, () async {
      as(managerId);
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 1650000,
          occurredOn: day(36),
          category: ExpenseCategory.equipment,
          description: 'Mini excavator with driver, 3 days',
          vendor: 'Location Engins Mvan',
          stageId: stageId(0),
        ),
        receiptFile: 'receipt_excavator.png',
      );
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 400000,
          occurredOn: day(35),
          category: ExpenseCategory.labour,
          description: 'Site clearing team, 4 workers for 5 days',
          stageId: stageId(0),
        ),
      );
    });
    await step(33, 10, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(0),
        itemId(0, 1),
        'site_preparation_2.jpg',
      );
    });
    await step(32, 17, () async {
      as(managerId);
      await stages.submit(session, projectId, stageId(0));
    });
    await step(31, 20, () async {
      as(ownerId);
      await stages.review(
        session,
        projectId,
        stageId(0),
        ReviewDecision.approved,
        comment: 'Clean setting out, thank you Joseph.',
      );
    });

    // --- Foundation: paid, done, approved by the co-funder.
    await step(31, 21, () async {
      await _release(
        session,
        ledger,
        as: () => as(ownerId),
        confirmAs: () => as(managerId),
        projectId: projectId,
        draft: ReleaseDraft(
          amountMinor: 28000000,
          occurredOn: day(31),
          method: ReleaseMethod.bankTransfer,
          reference: 'TRF-2026-0931',
          stageId: stageId(1),
          note: 'Foundation: footings, ground beams and backfill.',
        ),
      );
    });
    await step(29, 16, () async {
      as(managerId);
      await updates.create(
        session,
        projectId,
        ProgressUpdateDraft(
          text:
              'Footing pits are dug and the lean concrete is poured in '
              'all of them. Steel cages for the column footings are being '
              'tied on site.',
          stageId: stageId(1),
          workersCount: 9,
          weather: Weather.rain,
          issues:
              'Heavy rain on Tuesday flooded two pits. We pumped them out; '
              'one day lost.',
        ),
      );
    });
    await step(27, 12, () async {
      as(managerId);
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 4550000,
          occurredOn: day(27),
          category: ExpenseCategory.materials,
          description: 'Cement, 700 bags of 50 kg',
          vendor: 'Quincaillerie du Centre, Mvog-Mbi',
          stageId: stageId(1),
        ),
        receiptFile: 'receipt_cement.png',
      );
    });
    await step(25, 9, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(1),
        itemId(1, 0),
        'foundation_1.jpg',
      );
    });
    await step(24, 14, () async {
      as(managerId);
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 7900000,
          occurredOn: day(24),
          category: ExpenseCategory.materials,
          description: 'Reinforcement steel, 10, 12 and 14 mm bars',
          vendor: 'Fers et Aciers Etoudi',
          stageId: stageId(1),
        ),
        receiptFile: 'receipt_rebar.png',
      );
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 2600000,
          occurredOn: day(23),
          category: ExpenseCategory.materials,
          description: 'Gravel and sand, 6 truckloads',
          stageId: stageId(1),
        ),
      );
    });
    await step(22, 11, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(1),
        itemId(1, 1),
        'foundation_2.jpg',
      );
    });
    await step(20, 18, () async {
      as(managerId);
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 3200000,
          occurredOn: day(20),
          category: ExpenseCategory.labour,
          description: 'Masons and steel fixers, foundation works',
          stageId: stageId(1),
        ),
      );
    });
    await step(19, 10, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(1),
        itemId(1, 2),
        'foundation_3.jpg',
      );
    });
    await step(18, 16, () async {
      as(managerId);
      await stages.submit(session, projectId, stageId(1));
    });
    await step(17, 19, () async {
      as(coFunderId);
      await stages.review(
        session,
        projectId,
        stageId(1),
        ReviewDecision.approved,
        comment: 'The ground beams look straight and clean.',
      );
    });

    // --- Ground floor: released, not confirmed yet; submitted yesterday.
    await step(16, 10, () async {
      as(ownerId);
      await ledger.recordRelease(
        session,
        projectId,
        ReleaseDraft(
          amountMinor: 15000000,
          occurredOn: day(16),
          method: ReleaseMethod.bankTransfer,
          reference: 'TRF-2026-1016',
          stageId: stageId(2),
          note: 'Ground floor columns and first-floor slab, first part.',
        ),
      );
    });
    await step(14, 9, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(2),
        itemId(2, 0),
        'ground_floor_1.jpg',
      );
    });
    await step(10, 17, () async {
      as(managerId);
      await updates.create(
        session,
        projectId,
        ProgressUpdateDraft(
          text:
              'All the ground floor columns are cast. The props and '
              'formwork for the first-floor slab go up this week.',
          stageId: stageId(2),
          workersCount: 14,
          weather: Weather.cloudy,
          issues: 'The plywood for the formwork arrived two days late.',
        ),
      );
    });
    await step(8, 11, () async {
      as(managerId);
      await _capture(
        session,
        evidence,
        projectId,
        stageId(2),
        itemId(2, 1),
        'ground_floor_2.jpg',
      );
    });
    await step(5, 15, () async {
      as(managerId);
      // On the slab, the phone's fix was weak: partly verified (V3).
      await _capture(
        session,
        evidence,
        projectId,
        stageId(2),
        itemId(2, 2),
        'ground_floor_3.jpg',
        accuracyM: 45,
      );
    });
    await step(3, 13, () async {
      as(managerId);
      await _expense(
        session,
        ledger,
        projectId,
        ExpenseDraft(
          amountMinor: 350000,
          occurredOn: day(3),
          category: ExpenseCategory.transport,
          description: 'Delivery of formwork plywood and props',
          stageId: stageId(2),
        ),
      );
    });
    await step(1, 18, () async {
      as(managerId);
      await stages.submit(session, projectId, stageId(2));
    });

    // --- Today: an invitation waiting for a viewer.
    await step(0, 9, () async {
      as(ownerId);
      await membership.createInvitation(session, projectId, ProjectRole.viewer);
    });
    } catch (_) {
      // Never leave a half-made demo: the next start would skip it.
      session.updateAuthenticated(null);
      if (made) await const AccountService().deleteProject(session, projectId);
      rethrow;
    } finally {
      session.updateAuthenticated(null);
    }
    return DemoSeedOutcome.created;
  }

  /// The six stages of a 5-storey building, with what each must show.
  List<StageDraft> _plan() {
    StageDraft stage(
      String name,
      int budget,
      int startsIn,
      int weeks,
      List<String> items,
    ) => StageDraft(
      name: name,
      budgetMinor: budget,
      plannedStart: _date(_now.add(Duration(days: startsIn))),
      plannedEnd: _date(_now.add(Duration(days: startsIn + weeks * 7))),
      items: [
        for (final label in items)
          ChecklistItemDraft(label: label, isRequired: true),
      ],
    );
    return [
      stage('Site preparation', 4500000, -42, 2, [
        'The cleared plot with the setting out',
        'The excavation of the foundation',
      ]),
      stage('Foundation', 28000000, -30, 3, [
        'Footing reinforcement before the pour',
        'Footings and ground beams cast',
        'The finished, backfilled foundation',
      ]),
      stage('Ground floor: columns and slab', 32000000, -16, 3, [
        'The ground floor columns after casting',
        'Slab formwork and props',
        'Slab reinforcement before the pour',
      ]),
      stage('Upper floors: structure, floors 1 to 4', 85000000, 7, 16, [
        'Each floor slab before the pour',
        'The columns of each floor',
      ]),
      stage('Roof', 18000000, 120, 4, [
        'The roof structure',
        'The finished roof',
      ]),
      stage('Finishing', 40000000, 150, 12, [
        'Plastering and tiling',
        'Doors, windows and paint',
      ]),
    ];
  }

  /// A site photo taken in the app on the plot: committed, stored, finalized.
  Future<void> _capture(
    Session session,
    EvidenceEndpoint evidence,
    int projectId,
    int stageId,
    int itemId,
    String file, {
    double accuracyM = 6,
  }) async {
    final bytes = photo(file);
    final commit = await evidence.commit(
      session,
      projectId,
      EvidenceCommit(
        stageId: stageId,
        checklistItemId: itemId,
        sha256: sha256.convert(bytes).toString(),
        deviceCapturedAt: DateTime.now().toUtc(),
        lat: siteLat + 0.00008,
        lng: siteLng - 0.00006,
        accuracyM: accuracyM,
        altitudeM: 726,
        isMockLocation: false,
        capturedInApp: true,
        deviceModel: 'Tecno Camon 30',
        osVersion: 'Android 14',
        appVersion: '1.0.0',
      ),
    );
    await session.storage.storeFile(
      storageId: _storageId,
      path: commit.evidence.photoPath,
      byteData: ByteData.sublistView(bytes),
    );
    await evidence.finalize(session, projectId, commit.evidence.id!);
  }

  /// An expense, with its receipt photo when [receiptFile] is given.
  Future<void> _expense(
    Session session,
    LedgerEndpoint ledger,
    int projectId,
    ExpenseDraft draft, {
    String? receiptFile,
  }) async {
    if (receiptFile == null) {
      await ledger.recordExpense(session, projectId, draft);
      return;
    }
    final bytes = receipt(receiptFile);
    final upload = await ledger.receiptUpload(session, projectId);
    await session.storage.storeFile(
      storageId: _storageId,
      path: upload.path,
      byteData: ByteData.sublistView(bytes),
    );
    await ledger.recordExpense(
      session,
      projectId,
      draft.copyWith(
        receiptPath: upload.path,
        receiptSha256: sha256.convert(bytes).toString(),
      ),
    );
  }

  /// A release recorded by the owner and confirmed by the site manager.
  Future<void> _release(
    Session session,
    LedgerEndpoint ledger, {
    required void Function() as,
    required void Function() confirmAs,
    required int projectId,
    required ReleaseDraft draft,
  }) async {
    as();
    final entry = await ledger.recordRelease(session, projectId, draft);
    confirmAs();
    await ledger.confirmRelease(session, projectId, entry.id!);
  }

  /// The person's user, created with their email sign-in, name and settings
  /// the first time.
  Future<UuidValue> _account(
    Session session,
    DemoPerson person,
    String password,
  ) async {
    final existing = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(person.email),
    );
    if (existing != null) return existing.authUserId;
    final user = await AuthServices.instance.authUsers.create(session);
    await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: user.id,
      email: person.email,
      password: password,
    );
    await AuthServices.instance.userProfiles.createUserProfile(
      session,
      user.id,
      UserProfileData(fullName: person.fullName, email: person.email),
    );
    final now = DateTime.now().toUtc();
    await UserSettings.db.insertRow(
      session,
      UserSettings(
        authUserId: user.id,
        countryCode: person.countryCode,
        locale: person.locale,
        createdAt: now,
        updatedAt: now,
      ),
    );
    return user.id;
  }

  /// The owner's demo project, if there is one.
  Future<Project?> _find(Session session, UuidValue ownerId) async {
    final owned = await ProjectMember.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(ownerId) & t.role.equals(ProjectRole.owner),
    );
    for (final membership in owned) {
      final project = await Project.db.findById(session, membership.projectId);
      if (project?.name == projectName) return project;
    }
    return null;
  }

  /// Whether the story reached its last step: the viewer's invitation.
  Future<bool> _complete(Session session, int projectId) async =>
      await Invitation.db.count(
        session,
        where: (t) =>
            t.projectId.equals(projectId) & t.role.equals(ProjectRole.viewer),
      ) >
      0;

  /// [daysAgo] at [hour] o'clock in Yaoundé (UTC+1).
  DateTime _at(int daysAgo, int hour) {
    final day = _now.subtract(Duration(days: daysAgo));
    return DateTime.utc(day.year, day.month, day.day, hour - 1);
  }

  static DateTime _date(DateTime when) =>
      DateTime.utc(when.year, when.month, when.day);

  /// The demo project's timestamps (only those columns, never planned
  /// dates or expiries) written since [from], moved back by [by].
  static const _columns = {
    'project': ['createdAt', 'updatedAt'],
    'project_member': ['joinedAt'],
    'invitation': ['createdAt'],
    'site': ['validatedAt', 'updatedAt'],
    'site_proposal': ['proposedAt', 'decidedAt'],
    'stage': ['startedAt', 'submittedAt', 'approvedAt', 'createdAt', 'updatedAt'],
    'stage_review': ['createdAt'],
    'evidence': ['deviceCapturedAt', 'serverCommittedAt', 'finalizedAt'],
    'ledger_entry': ['confirmedAt', 'createdAt'],
    'progress_update': ['createdAt'],
    'activity_event': ['createdAt'],
    'notification': ['createdAt', 'readAt'],
    'audit_log': ['createdAt'],
  };

  Future<void> _backdate(
    Session session,
    int projectId, {
    required DateTime from,
    required Duration by,
  }) async {
    final since = from.toUtc().toIso8601String().replaceFirst('Z', '');
    final seconds = by.inSeconds;
    for (final MapEntry(key: table, value: columns) in _columns.entries) {
      final scope = switch (table) {
        'project' => '"id" = $projectId',
        'stage_review' =>
          '"stageId" IN (SELECT "id" FROM "stage" WHERE "projectId" = $projectId)',
        _ => '"projectId" = $projectId',
      };
      for (final column in columns) {
        await session.db.unsafeExecute(
          'UPDATE "$table" SET "$column" = "$column" - '
          "interval '$seconds seconds' "
          'WHERE $scope AND "$column" >= \'$since\'',
        );
      }
    }
  }
}
