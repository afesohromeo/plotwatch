// The screens of the design check (doc/05 §9.3). See harness.dart.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../test/helpers/helpers.dart';
import 'harness.dart';

void main() {
  setUpAll(() async {
    setUpTestLocalization();
    await loadFonts();
  });

  // --- Project list.
  Widget projectList() {
    final bloc = MockProjectListBloc();
    final items = [
      ProjectSummary(
        project: project(),
        myRole: ProjectRole.owner,
        progressPercent: 62,
        stages: stages,
        budgetTotalMinor: 12500000,
        latestEvidenceId: 9,
      ),
      ProjectSummary(
        project: testProject(
          id: 2,
          name: 'Duplex Bafoussam',
          status: ProjectStatus.paused,
        ),
        myRole: ProjectRole.coFunder,
        progressPercent: 15,
        stages: [
          StageBrief(
            id: 5,
            name: 'Site preparation',
            status: StageStatus.approved,
          ),
          for (var i = 6; i < 11; i++)
            StageBrief(id: i, name: 'Stage $i', status: StageStatus.notStarted),
        ],
        budgetTotalMinor: 9000000,
        latestEvidenceId: 20,
      ),
    ];
    whenListen(
      bloc,
      Stream.value(
        ProjectListState(
          projectsListStatus: GenericStatus.success,
          projects: items,
          paginatedProjects: items,
          maxProjects: true,
        ),
      ),
      initialState: const ProjectListState(),
    );
    return MultiBlocProvider(
      providers: [
        ...signedIn(),
        BlocProvider<ProjectListBloc>.value(value: bloc),
        BlocProvider<EvidenceMediaBloc>.value(value: mediaFor([9, 20])),
      ],
      child: const ProjectListPage(),
    );
  }

  for (final (name, size) in [('phone', phone), ('desktop', desktop)]) {
    testWidgets('project list $name', (tester) async {
      await shot(tester, 'projects_$name', size, projectList());
    });
  }

  // --- Project page, Overview tab, inside the shell.
  Widget overviewPage() {
    final page = MockProjectOverviewBloc();
    final state = ProjectOverviewState(
      overviewStatus: GenericStatus.success,
      overview: overview(),
      members: members,
    );
    when(() => page.state).thenReturn(state);
    final feedBloc = MockFeedBloc();
    when(() => feedBloc.state).thenReturn(
      FeedState(
        projectId: 1,
        activity: feed,
        activityListStatus: GenericStatus.success,
      ),
    );
    return MultiBlocProvider(
      providers: [
        ...signedIn(),
        BlocProvider<ProjectOverviewBloc>.value(value: page),
        BlocProvider<EvidenceMediaBloc>.value(value: mediaFor([9, 8])),
      ],
      child: ProjectShell(
        projectId: 1,
        location: '/projects/1',
        child: BlocProvider<FeedBloc>.value(
          value: feedBloc,
          child: const ProjectOverviewPage(projectId: 1),
        ),
      ),
    );
  }

  for (final (name, size) in [
    ('phone', phone),
    ('tablet', tablet),
    ('desktop', desktop),
  ]) {
    testWidgets('overview $name', (tester) async {
      await shot(tester, 'overview_$name', size, overviewPage());
    });
  }

  // --- Inside a project: wrap a page in the shell with its blocs.
  Widget inShell(
    String location,
    Widget page, {
    List<int> photos = const [9, 8, 7, 6],
  }) {
    final shellBloc = MockProjectOverviewBloc();
    when(() => shellBloc.state).thenReturn(
      ProjectOverviewState(
        overviewStatus: GenericStatus.success,
        overview: overview(),
      ),
    );
    return MultiBlocProvider(
      providers: [
        ...signedIn(),
        BlocProvider<ProjectOverviewBloc>.value(value: shellBloc),
        BlocProvider<EvidenceMediaBloc>.value(value: mediaFor(photos)),
      ],
      child: ProjectShell(projectId: 1, location: location, child: page),
    );
  }

  StageView view(
    int id,
    String name,
    StageStatus status,
    int order, {
    int? photo,
    DateTime? end,
  }) => StageView(
    stage: testStage(
      id: id,
      name: name,
      orderIndex: order,
      status: status,
      budgetMinor: [1500000, 6250000, 4000000, 750000][order],
    ).copyWith(projectId: 1, plannedEnd: end),
    items: [
      ChecklistItem(
        id: id * 10,
        stageId: id,
        orderIndex: 0,
        label: 'Wide shot of every wall',
        isRequired: true,
      ),
      ChecklistItem(
        id: id * 10 + 1,
        stageId: id,
        orderIndex: 1,
        label: 'Rebar at the corners',
        isRequired: true,
      ),
      ChecklistItem(
        id: id * 10 + 2,
        stageId: id,
        orderIndex: 2,
        label: 'Wall height with a tape',
        isRequired: false,
      ),
    ],
    itemsCovered: status == StageStatus.notStarted ? 0 : 3,
    latestEvidenceId: photo,
  );
  final plan = StagePlan(
    stages: [
      view(1, 'Site preparation', StageStatus.approved, 0, photo: 6),
      view(2, 'Foundation', StageStatus.approved, 1, photo: 7),
      view(
        3,
        'Walls',
        StageStatus.submitted,
        2,
        photo: 9,
        end: DateTime.utc(2026, 10, 4),
      ),
      view(4, 'Roof', StageStatus.notStarted, 3),
    ],
    budgetTotalMinor: 12500000,
    progressPercent: 62,
  );

  for (final (name, size) in [('phone', phone), ('tablet', tablet)]) {
    testWidgets('stages $name', (tester) async {
      final bloc = MockStagePlanBloc();
      when(() => bloc.state).thenReturn(
        StagePlanState(
          projectId: 1,
          overview: overview(),
          plan: plan,
          loadStatus: GenericStatus.success,
        ),
      );
      await shot(
        tester,
        'stages_$name',
        size,
        inShell(
          '/projects/1/stages',
          BlocProvider<StagePlanBloc>.value(
            value: bloc,
            child: const StagePlanPage(projectId: 1),
          ),
        ),
      );
    });
  }

  List<Evidence> captures() => [
    testEvidence(id: 9, checklistItemId: 30).copyWith(stageId: 3),
    testEvidence(
      id: 8,
      checklistItemId: 31,
      level: VerificationLevel.partiallyVerified,
    ).copyWith(stageId: 3),
    testEvidence(id: 7, checklistItemId: 32).copyWith(stageId: 3),
    testEvidence(id: 6, checklistItemId: 30).copyWith(stageId: 3),
  ];

  for (final (name, size) in [
    ('phone', phone),
    ('tablet', tablet),
    ('desktop', desktop),
  ]) {
    testWidgets('stage $name', (tester) async {
      final bloc = MockStageBloc();
      when(() => bloc.state).thenReturn(
        StageState(
          projectId: 1,
          stageId: 3,
          overview: overview(),
          view: plan.stages[2],
          evidence: captures(),
          loadStatus: GenericStatus.success,
        ),
      );
      await shot(
        tester,
        'stage_$name',
        size,
        inShell(
          '/projects/1/stages/3',
          MultiBlocProvider(
            providers: [
              BlocProvider<StageBloc>.value(value: bloc),
              BlocProvider<EvidenceMediaBloc>.value(
                value: mediaFor([9, 8, 7, 6]),
              ),
            ],
            child: const StagePage(projectId: 1, stageId: 3),
          ),
        ),
      );
    });

    testWidgets('photo $name', (tester) async {
      final bloc = MockEvidenceBloc();
      when(() => bloc.state).thenReturn(
        EvidenceState(
          projectId: 1,
          stageId: 3,
          evidenceId: 9,
          overview: overview(),
          stage: plan.stages[2].stage,
          evidence: captures().first.copyWith(
            capturedByName: 'Bob Mbarga',
            capturedByFormer: false,
          ),
          loadStatus: GenericStatus.success,
        ),
      );
      await shot(
        tester,
        'photo_$name',
        size,
        inShell(
          '/projects/1/stages/3/evidence/9',
          MultiBlocProvider(
            providers: [
              BlocProvider<EvidenceBloc>.value(value: bloc),
              BlocProvider<EvidenceMediaBloc>.value(value: mediaFor([9])),
            ],
            child: const EvidencePage(projectId: 1, stageId: 3, evidenceId: 9),
          ),
        ),
      );
    });
  }

  testWidgets('activity phone', (tester) async {
    final bloc = MockFeedBloc();
    final state = FeedState(
      projectId: 1,
      activity: feed,
      paginatedActivity: feed,
      maxActivity: true,
      activityListStatus: GenericStatus.success,
    );
    whenListen(bloc, Stream.value(state), initialState: const FeedState());
    await shot(
      tester,
      'activity_phone',
      phone,
      inShell(
        '/projects/1/feed',
        BlocProvider<FeedBloc>.value(
          value: bloc,
          child: const FeedPage(projectId: 1),
        ),
        photos: [9, 8],
      ),
    );
  });

  testWidgets('members phone', (tester) async {
    final bloc = MockMembersBloc();
    when(() => bloc.state).thenReturn(
      MembersState(
        membersStatus: GenericStatus.success,
        overview: overview(),
        members: members,
        invitations: [testInvitation()],
        formerMembers: [testFormerMember()],
      ),
    );
    await shot(
      tester,
      'members_phone',
      phone,
      inShell(
        '/projects/1/members',
        BlocProvider<MembersBloc>.value(
          value: bloc,
          child: const MembersPage(projectId: 1),
        ),
      ),
    );
  });

  testWidgets('notifications phone', (tester) async {
    final bloc = MockNotificationsBloc();
    final items = [
      testNotification(id: 7),
      testNotification(
        id: 6,
        type: NotificationType.progressUpdatePosted,
        payload: const {
          'actorName': 'Bob Mbarga',
          'projectName': 'Maison Douala',
          'excerpt': 'Walls are up on all four sides',
          'updateId': '4',
        },
      ),
      testNotification(
        id: 5,
        type: NotificationType.stageApproved,
        payload: const {
          'reviewerName': 'Chloe Ndi',
          'stageName': 'Foundation',
          'projectName': 'Maison Douala',
          'stageId': '2',
        },
        readAt: DateTime.utc(2026, 10, 8),
      ),
    ];
    final state = NotificationsState(
      unreadCount: 2,
      notifications: items,
      paginatedNotifications: items,
      maxNotifications: true,
      notificationsListStatus: GenericStatus.success,
    );
    whenListen(
      bloc,
      Stream.value(state),
      initialState: const NotificationsState(unreadCount: 2),
    );
    final auth = MockAuthenticationBloc();
    when(() => auth.state).thenReturn(
      const AuthenticationState(status: AuthenticationStatus.authenticated),
    );
    await shot(
      tester,
      'notifications_phone',
      phone,
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>.value(value: auth),
          BlocProvider<NotificationsBloc>.value(value: bloc),
        ],
        child: const NotificationsPage(),
      ),
    );
  });
}
