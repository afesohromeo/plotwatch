import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Server models as the API returns them, for tests.
Project testProject({
  int id = 1,
  String name = 'House in Bafoussam',
  ProjectStatus status = ProjectStatus.draft,
  String? description,
  DateTime? plannedStart,
  DateTime? plannedEnd,
}) => Project(
  id: id,
  name: name,
  description: description,
  type: ProjectType.newHouse,
  status: status,
  currencyCode: 'XAF',
  plannedStart: plannedStart,
  plannedEnd: plannedEnd,
  createdAt: DateTime.utc(2026, 10, 6),
  updatedAt: DateTime.utc(2026, 10, 6),
);

ProjectSummary testSummary({
  int id = 1,
  String name = 'House in Bafoussam',
  ProjectRole role = ProjectRole.owner,
  ProjectStatus status = ProjectStatus.draft,
}) => ProjectSummary(
  project: testProject(id: id, name: name, status: status),
  myRole: role,
  progressPercent: 0,
);

ProjectOverview testOverview({
  Project? project,
  Site? site,
  ProjectRole role = ProjectRole.owner,
  SiteProposal? pendingSiteProposal,
  bool canApprove = false,
  int stageCount = 0,
  int budgetTotalMinor = 0,
  int progressPercent = 0,
}) => ProjectOverview(
  project: project ?? testProject(),
  site: site,
  myRole: role,
  myCanApprove: canApprove,
  pendingSiteProposal: pendingSiteProposal,
  stageCount: stageCount,
  budgetTotalMinor: budgetTotalMinor,
  progressPercent: progressPercent,
);

Site testSite({int projectId = 1}) => Site(
  id: 1,
  projectId: projectId,
  centerLat: 5.4778,
  centerLng: 10.4176,
  plusCode: '6FW6FCHF+4V',
  radiusM: 50,
  validatedProposalId: 1,
  validatedBy: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
  validatedAt: DateTime.utc(2026, 10, 6),
  updatedAt: DateTime.utc(2026, 10, 6),
);

final testDetails = ProjectDetails(
  name: 'House in Bafoussam',
  description: 'Four bedrooms',
  type: ProjectType.newHouse,
  currencyCode: 'XAF',
);

Invitation testInvitation({
  int id = 1,
  ProjectRole role = ProjectRole.siteManager,
  String code = 'ABCD2345',
}) => Invitation(
  id: id,
  projectId: 1,
  role: role,
  code: code,
  status: InvitationStatus.pending,
  expiresAt: DateTime.utc(2026, 10, 14),
  createdBy: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
  createdAt: DateTime.utc(2026, 10, 7),
);

MemberView testMember({
  int id = 1,
  String fullName = 'Ada Lovelace',
  ProjectRole role = ProjectRole.owner,
}) => MemberView(
  member: ProjectMember(
    id: id,
    projectId: 1,
    authUserId: UuidValue.fromString(
      '00000000-0000-4000-8000-${id.toString().padLeft(12, '0')}',
    ),
    role: role,
    status: MemberStatus.active,
    joinedAt: DateTime.utc(2026, 10, 7),
  ),
  fullName: fullName,
  email: '${fullName.split(' ').first.toLowerCase()}@example.com',
);

final testPreview = InvitationPreview(
  projectName: 'House in Bafoussam',
  role: ProjectRole.siteManager,
  canApprove: false,
  inviterName: 'Ada Lovelace',
  expiresAt: DateTime.utc(2026, 10, 14),
);

SiteProposal testProposal({
  int id = 7,
  double accuracyM = 8,
  SiteProposalStatus status = SiteProposalStatus.pending,
}) => SiteProposal(
  id: id,
  projectId: 1,
  proposedBy: UuidValue.fromString('00000000-0000-4000-8000-000000000002'),
  lat: 5.4778,
  lng: 10.4176,
  accuracyM: accuracyM,
  proposedAt: DateTime.utc(2026, 10, 7, 9, 30),
  status: status,
);

GpsReading testReading({double accuracyM = 8, bool isMocked = false}) =>
    GpsReading(
      latitude: 5.4778,
      longitude: 10.4176,
      accuracyM: accuracyM,
      isMocked: isMocked,
    );

// Stages (doc/04c).
StageDraft testStageDraft({String name = 'Foundation', int budgetMinor = 0}) =>
    StageDraft(
      name: name,
      budgetMinor: budgetMinor,
      items: [ChecklistItemDraft(label: 'Wide shot', isRequired: true)],
    );

Stage testStage({
  int id = 1,
  String name = 'Foundation',
  int orderIndex = 0,
  int budgetMinor = 1500000,
  StageStatus status = StageStatus.notStarted,
}) => Stage(
  id: id,
  projectId: 1,
  orderIndex: orderIndex,
  name: name,
  budgetMinor: budgetMinor,
  status: status,
  createdAt: DateTime.utc(2026, 10, 8),
  updatedAt: DateTime.utc(2026, 10, 8),
);

StageView testStageView({
  int id = 1,
  String name = 'Foundation',
  int orderIndex = 0,
  int budgetMinor = 1500000,
  StageStatus status = StageStatus.notStarted,
}) => StageView(
  stage: testStage(
    id: id,
    name: name,
    orderIndex: orderIndex,
    budgetMinor: budgetMinor,
    status: status,
  ),
  items: [
    ChecklistItem(
      id: id * 10,
      stageId: id,
      orderIndex: 0,
      label: 'Wide shot',
      isRequired: true,
    ),
    ChecklistItem(
      id: id * 10 + 1,
      stageId: id,
      orderIndex: 1,
      label: 'Detail',
      isRequired: false,
    ),
  ],
  itemsCovered: 0,
);

StagePlan testStagePlan({List<StageView>? stages, int progressPercent = 0}) {
  final views =
      stages ??
      [
        testStageView(id: 1, name: 'Foundation', budgetMinor: 1500000),
        testStageView(id: 2, name: 'Walls', orderIndex: 1, budgetMinor: 500000),
      ];
  return StagePlan(
    stages: views,
    budgetTotalMinor: views.fold(0, (sum, v) => sum + v.stage.budgetMinor),
    progressPercent: progressPercent,
  );
}

// Captures (doc/04d).
EvidenceCommit testEvidenceCommit() => EvidenceCommit(
  stageId: 1,
  checklistItemId: 10,
  sha256: 'a' * 64,
  deviceCapturedAt: DateTime.utc(2026, 10, 9, 9),
  lat: 5.4778,
  lng: 10.4176,
  accuracyM: 8,
  isMockLocation: false,
  capturedInApp: true,
  deviceModel: 'Pixel 7',
  osVersion: 'Android 15',
  appVersion: '1.0.0',
);

List<VerificationCheck> testChecks({bool insidePassed = true}) => [
  for (final name in VerificationCheckName.values)
    VerificationCheck(
      name: name,
      passed: name != VerificationCheckName.insideSite || insidePassed,
      critical: true,
      details: name == VerificationCheckName.insideSite
          ? {'distanceM': insidePassed ? '4' : '137', 'allowedM': '58'}
          : null,
    ),
];

/// The site manager of the stage fixtures.
const testManagerId = '00000000-0000-4000-8000-000000000002';

Evidence testEvidence({
  int id = 9,
  int checklistItemId = 10,
  EvidenceStatus status = EvidenceStatus.finalized,
  VerificationLevel level = VerificationLevel.verified,
  String capturedBy = testManagerId,
  String? retractedReason,
}) => Evidence(
  id: id,
  projectId: 1,
  stageId: 1,
  checklistItemId: checklistItemId,
  capturedBy: UuidValue.fromString(capturedBy),
  status: status,
  sha256: 'a' * 64,
  photoPath: 'projects/1/evidence/$id/photo.jpg',
  thumbPath: 'projects/1/evidence/$id/thumb.jpg',
  fileSizeBytes: 800000,
  deviceCapturedAt: DateTime.utc(2026, 10, 9, 9),
  serverCommittedAt: DateTime.utc(2026, 10, 9, 9, 0, 3),
  finalizedAt: DateTime.utc(2026, 10, 9, 9, 0, 5),
  lat: 5.4778,
  lng: 10.4176,
  accuracyM: 8,
  isMockLocation: false,
  capturedInApp: true,
  distanceFromSiteM: 4,
  deviceModel: 'Pixel 7',
  osVersion: 'Android 15',
  appVersion: '1.0.0',
  verificationLevel: level,
  checks: status == EvidenceStatus.committed
      ? null
      : testChecks(insidePassed: level != VerificationLevel.unverified),
  retractedReason: retractedReason,
);

// Feed, notifications and updates (doc/04e).
ActivityEntry testActivity({
  int id = 1,
  ActivityType type = ActivityType.stageApproved,
  String targetType = 'stage',
  int? targetId = 2,
  Map<String, String>? payload = const {'name': 'Foundation'},
  String? actorName = 'Ada',
}) => ActivityEntry(
  event: ActivityEvent(
    id: id,
    projectId: 1,
    actorId: UuidValue.fromString(testManagerId),
    type: type,
    targetType: targetType,
    targetId: targetId,
    payload: payload,
    createdAt: DateTime.utc(2026, 10, 9, 10),
  ),
  actorName: actorName,
);

AppNotification testNotification({
  int id = 1,
  NotificationType type = NotificationType.stageSubmitted,
  Map<String, String>? payload = const {
    'stageId': '2',
    'stageName': 'Foundation',
    'projectName': 'Maison Douala',
    'actorName': 'Bob',
  },
  DateTime? readAt,
}) => AppNotification(
  id: id,
  userId: UuidValue.fromString(testManagerId),
  projectId: 1,
  type: type,
  payload: payload,
  readAt: readAt,
  createdAt: DateTime.utc(2026, 10, 9, 10),
);

ProgressUpdate testUpdate({int id = 4, int? stageId = 2}) => ProgressUpdate(
  id: id,
  projectId: 1,
  stageId: stageId,
  authorId: UuidValue.fromString(testManagerId),
  text: 'Concrete poured on the east side.',
  workersCount: 6,
  weather: Weather.sunny,
  issues: 'Cement delivery late.',
  createdAt: DateTime.utc(2026, 10, 9, 16),
);
