import 'package:plotwatch_server/src/generated/protocol.dart';
import 'package:plotwatch_server/src/services/permission_service.dart';
import 'package:test/test.dart';

// Plan: doc/04b-m2-projects-site-members.md, group A (decision M2-5).
// The expected cells are copied from doc/02 §3.2, so a wrong cell in
// PermissionService fails here.
const _y = true;
const _n = false;

/// Columns: owner, co-funder with approval rights, co-funder without,
/// viewer, site manager.
const _matrix = <ProjectAction, List<bool>>{
  ProjectAction.viewProject: [_y, _y, _y, _y, _y],
  ProjectAction.editProject: [_y, _n, _n, _n, _n],
  ProjectAction.archiveProject: [_y, _n, _n, _n, _n],
  ProjectAction.manageMembers: [_y, _n, _n, _n, _n],
  ProjectAction.manageStages: [_y, _n, _n, _n, _n],
  ProjectAction.captureEvidence: [_n, _n, _n, _n, _y],
  ProjectAction.postUpdates: [_n, _n, _n, _n, _y],
  ProjectAction.submitStage: [_n, _n, _n, _n, _y],
  ProjectAction.reviewStage: [_y, _y, _n, _n, _n],
  ProjectAction.createEvidenceRequests: [_y, _y, _n, _n, _n],
  ProjectAction.fulfilEvidenceRequests: [_n, _n, _n, _n, _y],
  ProjectAction.createFundRequests: [_n, _n, _n, _n, _y],
  ProjectAction.decideFundRequests: [_y, _y, _n, _n, _n],
  ProjectAction.recordFundReleases: [_y, _y, _n, _n, _n],
  ProjectAction.confirmFundReceipt: [_n, _n, _n, _n, _y],
  ProjectAction.recordExpenses: [_n, _n, _n, _n, _y],
  ProjectAction.comment: [_y, _y, _y, _n, _y],
  ProjectAction.createShareLinks: [_y, _y, _n, _n, _n],
};

const _callers = [
  (name: 'the owner', role: ProjectRole.owner, canApprove: false),
  (
    name: 'a co-funder who can approve',
    role: ProjectRole.coFunder,
    canApprove: true,
  ),
  (
    name: 'a co-funder who cannot approve',
    role: ProjectRole.coFunder,
    canApprove: false,
  ),
  (name: 'a viewer', role: ProjectRole.viewer, canApprove: false),
  (name: 'a site manager', role: ProjectRole.siteManager, canApprove: false),
];

void main() {
  test('Given the permission matrix then every project action has a row', () {
    expect(_matrix.keys.toSet(), ProjectAction.values.toSet());
  });

  for (final MapEntry(key: action, value: cells) in _matrix.entries) {
    for (final (index, caller) in _callers.indexed) {
      final expected = cells[index];
      test('Given ${caller.name} when checking ${action.name} then it is '
          '${expected ? 'allowed' : 'denied'}', () {
        expect(
          PermissionService.isAllowed(
            action,
            role: caller.role,
            canApprove: caller.canApprove,
          ),
          expected,
        );
      });
    }
  }

  test('Given a site manager or viewer with the approval flag set then it '
      'grants nothing: it only applies to co-funders', () {
    for (final role in [ProjectRole.siteManager, ProjectRole.viewer]) {
      for (final action in ProjectAction.values) {
        expect(
          PermissionService.isAllowed(action, role: role, canApprove: true),
          PermissionService.isAllowed(action, role: role, canApprove: false),
          reason: '$role ${action.name}',
        );
      }
    }
  });
}
