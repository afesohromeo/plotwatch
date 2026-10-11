/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// What happened on a project, shown in the activity feed (FEED). Streamed
/// from M5; written from M2 on.
enum ActivityType implements _is.SerializableModel {
  projectCreated,
  projectUpdated,
  projectStatusChanged,
  siteProposed,
  siteProposalRejected,
  siteChanged,
  memberJoined,
  memberRemoved,
  memberRoleChanged,
  stagePlanChanged,
  stageStarted,
  evidenceCaptured,
  evidenceRetracted,
  stageSubmitted,
  stageApproved,
  stageChangesRequested,
  progressUpdatePosted,
  fundReleased,
  releaseConfirmed,
  expenseRecorded,
  entryReversed;

  static ActivityType fromJson(String name) {
    switch (name) {
      case 'projectCreated':
        return ActivityType.projectCreated;
      case 'projectUpdated':
        return ActivityType.projectUpdated;
      case 'projectStatusChanged':
        return ActivityType.projectStatusChanged;
      case 'siteProposed':
        return ActivityType.siteProposed;
      case 'siteProposalRejected':
        return ActivityType.siteProposalRejected;
      case 'siteChanged':
        return ActivityType.siteChanged;
      case 'memberJoined':
        return ActivityType.memberJoined;
      case 'memberRemoved':
        return ActivityType.memberRemoved;
      case 'memberRoleChanged':
        return ActivityType.memberRoleChanged;
      case 'stagePlanChanged':
        return ActivityType.stagePlanChanged;
      case 'stageStarted':
        return ActivityType.stageStarted;
      case 'evidenceCaptured':
        return ActivityType.evidenceCaptured;
      case 'evidenceRetracted':
        return ActivityType.evidenceRetracted;
      case 'stageSubmitted':
        return ActivityType.stageSubmitted;
      case 'stageApproved':
        return ActivityType.stageApproved;
      case 'stageChangesRequested':
        return ActivityType.stageChangesRequested;
      case 'progressUpdatePosted':
        return ActivityType.progressUpdatePosted;
      case 'fundReleased':
        return ActivityType.fundReleased;
      case 'releaseConfirmed':
        return ActivityType.releaseConfirmed;
      case 'expenseRecorded':
        return ActivityType.expenseRecorded;
      case 'entryReversed':
        return ActivityType.entryReversed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ActivityType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
