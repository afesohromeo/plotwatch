import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Server models as the API returns them, for tests.
Project testProject({
  int id = 1,
  String name = 'House in Bafoussam',
  ProjectStatus status = ProjectStatus.draft,
  String? description,
  DateTime? plannedStart,
  DateTime? plannedEnd,
}) =>
    Project(
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
}) =>
    ProjectSummary(
      project: testProject(id: id, name: name, status: status),
      myRole: role,
      progressPercent: 0,
    );

ProjectOverview testOverview({
  Project? project,
  Site? site,
  ProjectRole role = ProjectRole.owner,
}) =>
    ProjectOverview(
      project: project ?? testProject(),
      site: site,
      myRole: role,
      myCanApprove: false,
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
