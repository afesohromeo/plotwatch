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

/// An invitation can be used once (MEMB-02). `expired` is set when someone
/// tries a code after its expiry; until then a pending code past its expiry is
/// treated as expired.
enum InvitationStatus implements _isc.SerializableModel {
  pending,
  accepted,
  cancelled,
  expired;

  static InvitationStatus fromJson(String name) {
    switch (name) {
      case 'pending':
        return InvitationStatus.pending;
      case 'accepted':
        return InvitationStatus.accepted;
      case 'cancelled':
        return InvitationStatus.cancelled;
      case 'expired':
        return InvitationStatus.expired;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "InvitationStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
