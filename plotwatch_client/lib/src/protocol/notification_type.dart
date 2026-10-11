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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// What a notification is about (NOT-02 core subset, doc/04e M5-4).
enum NotificationType implements _isc.SerializableModel {
  stageSubmitted,
  stageApproved,
  stageChangesRequested,
  memberJoined,
  progressUpdatePosted,
  fundReleased,
  releaseConfirmed,
  expenseRecorded,
  entryReversed;

  static NotificationType fromJson(String name) {
    switch (name) {
      case 'stageSubmitted':
        return NotificationType.stageSubmitted;
      case 'stageApproved':
        return NotificationType.stageApproved;
      case 'stageChangesRequested':
        return NotificationType.stageChangesRequested;
      case 'memberJoined':
        return NotificationType.memberJoined;
      case 'progressUpdatePosted':
        return NotificationType.progressUpdatePosted;
      case 'fundReleased':
        return NotificationType.fundReleased;
      case 'releaseConfirmed':
        return NotificationType.releaseConfirmed;
      case 'expenseRecorded':
        return NotificationType.expenseRecorded;
      case 'entryReversed':
        return NotificationType.entryReversed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "NotificationType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
