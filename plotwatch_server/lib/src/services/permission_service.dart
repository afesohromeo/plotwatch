import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// One value per row of the permission matrix (doc/02 §3.2), including the
/// rows used from M3 on, so later milestones only call [PermissionService].
enum ProjectAction {
  viewProject,
  editProject,
  archiveProject,
  manageMembers,
  manageStages,
  captureEvidence,
  postUpdates,
  submitStage,
  reviewStage,
  createEvidenceRequests,
  fulfilEvidenceRequests,
  createFundRequests,
  decideFundRequests,
  recordFundReleases,
  confirmFundReceipt,
  recordExpenses,
  comment,
  createShareLinks,
}

/// Checks what the caller may do on a project (decision M2-5). Every endpoint
/// that touches a project calls [require] first; hiding buttons in the app is
/// never the only protection.
class PermissionService {
  const PermissionService();

  /// The matrix of doc/02 §3.2. `canApprove` only counts for co-funders.
  static bool isAllowed(
    ProjectAction action, {
    required ProjectRole role,
    required bool canApprove,
  }) {
    final isOwner = role == ProjectRole.owner;
    final isSiteManager = role == ProjectRole.siteManager;
    final isApprover = isOwner || (role == ProjectRole.coFunder && canApprove);

    return switch (action) {
      ProjectAction.viewProject => true,
      ProjectAction.editProject ||
      ProjectAction.archiveProject ||
      ProjectAction.manageMembers ||
      ProjectAction.manageStages => isOwner,
      ProjectAction.captureEvidence ||
      ProjectAction.postUpdates ||
      ProjectAction.submitStage ||
      ProjectAction.fulfilEvidenceRequests ||
      ProjectAction.createFundRequests ||
      ProjectAction.confirmFundReceipt ||
      ProjectAction.recordExpenses => isSiteManager,
      ProjectAction.reviewStage ||
      ProjectAction.createEvidenceRequests ||
      ProjectAction.decideFundRequests ||
      ProjectAction.recordFundReleases ||
      ProjectAction.createShareLinks => isApprover,
      ProjectAction.comment => role != ProjectRole.viewer,
    };
  }

  /// Returns the caller's active membership of [projectId], or throws
  /// [AppException]:
  /// - `projectNotFound` when the project doesn't exist **or** the caller
  ///   isn't an active member, so outsiders can't tell which projects exist;
  /// - `permissionDenied` when the caller is a member without the right.
  Future<ProjectMember> require(
    Session session,
    int projectId,
    ProjectAction action, {
    Transaction? transaction,
  }) async {
    final userId = session.authenticated?.authUserId;
    final member = userId == null
        ? null
        : await ProjectMember.db.findFirstRow(
            session,
            where: (t) =>
                t.projectId.equals(projectId) &
                t.authUserId.equals(userId) &
                t.status.equals(MemberStatus.active),
            transaction: transaction,
          );
    if (member == null) {
      throw AppException(code: AppErrorCode.projectNotFound);
    }
    if (!isAllowed(action, role: member.role, canApprove: member.canApprove)) {
      throw AppException(code: AppErrorCode.permissionDenied);
    }
    return member;
  }
}
