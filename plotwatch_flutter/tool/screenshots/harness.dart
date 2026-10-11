// Screenshot harness for the design check (doc/05 §9.3). Not part of the
// test suite: run with
//   flutter test --update-goldens tool/screenshots/
// and look at tool/screenshots/out/*.png.
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

import '../../test/helpers/helpers.dart';

const phone = Size(390, 844);
const tablet = Size(1024, 768);
const desktop = Size(1440, 900);

final _root = GlobalKey();

class MockProjectListBloc extends MockBloc<ProjectListEvent, ProjectListState>
    implements ProjectListBloc {}

class MockProjectOverviewBloc
    extends MockBloc<ProjectOverviewEvent, ProjectOverviewState>
    implements ProjectOverviewBloc {}

class MockEvidenceMediaBloc
    extends MockBloc<EvidenceMediaEvent, EvidenceMediaState>
    implements EvidenceMediaBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockStagePlanBloc extends MockBloc<StagePlanEvent, StagePlanState>
    implements StagePlanBloc {}

class MockStageBloc extends MockBloc<StageEvent, StageState>
    implements StageBloc {}

class MockEvidenceBloc extends MockBloc<EvidenceEvent, EvidenceState>
    implements EvidenceBloc {}

class MockUpdateBloc extends MockBloc<UpdateEvent, UpdateState>
    implements UpdateBloc {}

class MockUpdateFormBloc extends MockBloc<UpdateFormEvent, UpdateFormState>
    implements UpdateFormBloc {}

class MockMembersBloc extends MockBloc<MembersEvent, MembersState>
    implements MembersBloc {}

Future<void> loadFonts() async {
  Future<ByteData> bytes(String path) async =>
      ByteData.view((await File(path).readAsBytes()).buffer);
  final manrope = FontLoader('Manrope');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
    manrope.addFont(bytes('assets/fonts/Manrope-$weight.ttf'));
  }
  await manrope.load();
  final root = Platform.environment['FLUTTER_ROOT'] ?? '';
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      bytes(
        '$root/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
      ),
    );
  await icons.load();
}

/// The stand-in site photos.
final photoA = File('tool/screenshots/photo_a.png').readAsBytesSync();
final photoB = File('tool/screenshots/photo_b.png').readAsBytesSync();

/// Thumbnails and photos for these capture IDs.
MockEvidenceMediaBloc mediaFor(List<int> ids) {
  final bloc = MockEvidenceMediaBloc();
  final images = <String, Uint8List>{
    for (final (i, id) in ids.indexed) ...{
      EvidenceMediaState.keyFor(id, MediaVariant.thumbnail): i.isEven
          ? photoA
          : photoB,
      EvidenceMediaState.keyFor(id, MediaVariant.photo): i.isEven
          ? photoA
          : photoB,
    },
  };
  when(() => bloc.state).thenReturn(EvidenceMediaState(images: images));
  return bloc;
}

/// Signed in, with the bell's unread count.
List<BlocProvider> signedIn({int unread = 3}) {
  final auth = MockAuthenticationBloc();
  when(() => auth.state).thenReturn(
    const AuthenticationState(status: AuthenticationStatus.authenticated),
  );
  final notifications = MockNotificationsBloc();
  when(
    () => notifications.state,
  ).thenReturn(NotificationsState(unreadCount: unread));
  return [
    BlocProvider<AuthenticationBloc>.value(value: auth),
    BlocProvider<NotificationsBloc>.value(value: notifications),
  ];
}

Future<void> shot(
  WidgetTester tester,
  String name,
  Size size,
  Widget page,
) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  // flutter_test draws elevation as a black outline unless told not to.
  debugDisableShadows = false;
  addTearDown(() => debugDisableShadows = true);
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PlotwatchTheme.light(customColors),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepaintBoundary(key: _root, child: page),
    ),
  );
  await tester.pump();
  // Decode the photos for real, then draw them.
  final context = tester.element(find.byKey(_root));
  await tester.runAsync(() async {
    for (final bytes in [photoA, photoB]) {
      await precacheImage(MemoryImage(bytes), context);
    }
  });
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 200));
  await expectLater(find.byKey(_root), matchesGoldenFile('out/$name.png'));
}

/// The sample project of the canvas.
final now = DateTime.now().toUtc();
final stages = [
  StageBrief(id: 1, name: 'Site preparation', status: StageStatus.approved),
  StageBrief(id: 2, name: 'Foundation', status: StageStatus.approved),
  StageBrief(id: 3, name: 'Walls', status: StageStatus.submitted),
  StageBrief(id: 4, name: 'Roof', status: StageStatus.notStarted),
];
Project project({ProjectStatus status = ProjectStatus.active}) => testProject(
  name: 'Maison Douala',
  status: status,
  plannedEnd: DateTime.utc(2026, 11, 30),
);
ProjectOverview overview() => ProjectOverview(
  project: project(),
  site: testSite(),
  myRole: ProjectRole.owner,
  myCanApprove: false,
  stageCount: 4,
  budgetTotalMinor: 12500000,
  progressPercent: 62,
  approvedStageCount: 2,
  stages: stages,
);
final members = [
  testMember(id: 1, fullName: 'Ada Lovelace'),
  testMember(id: 2, fullName: 'Bob Mbarga', role: ProjectRole.siteManager),
  testMember(id: 3, fullName: 'Chloe Ndi', role: ProjectRole.coFunder),
  testMember(id: 4, fullName: 'Eve Tchio', role: ProjectRole.viewer),
];
ActivityEntry activity(
  int id,
  ActivityType type,
  Map<String, String> payload, {
  String actor = 'Bob Mbarga',
  int? targetId,
  Duration ago = Duration.zero,
}) => ActivityEntry(
  event: ActivityEvent(
    id: id,
    projectId: 1,
    actorId: UuidValue.fromString(testManagerId),
    type: type,
    targetType: 'stage',
    targetId: targetId ?? 3,
    payload: payload,
    createdAt: now.subtract(ago),
  ),
  actorName: actor,
);
final feed = [
  activity(14, ActivityType.progressUpdatePosted, {
    'excerpt': 'Walls are up on all four sides. Cement came late.',
  }, targetId: 4),
  activity(13, ActivityType.stageSubmitted, {
    'name': 'Walls',
  }, ago: const Duration(minutes: 50)),
  activity(
    12,
    ActivityType.evidenceCaptured,
    {'verificationLevel': 'verified', 'stageId': '3'},
    targetId: 9,
    ago: const Duration(hours: 1),
  ),
  activity(
    11,
    ActivityType.evidenceCaptured,
    {'verificationLevel': 'partiallyVerified', 'stageId': '3'},
    targetId: 8,
    ago: const Duration(hours: 2),
  ),
  activity(
    10,
    ActivityType.stageApproved,
    {'name': 'Foundation'},
    actor: 'Ada Lovelace',
    ago: const Duration(days: 1),
  ),
  activity(
    9,
    ActivityType.memberJoined,
    {'role': 'coFunder'},
    actor: 'Chloe Ndi',
    ago: const Duration(days: 1, hours: 2),
  ),
];
