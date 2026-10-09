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
import 'package:plotwatch_server/src/generated/protocol.dart' as _irbavk3a;
import 'package:serverpod/serverpod.dart' as _is;
import 'notification.dart' as _irt10kca;

/// A page of the user's notifications, newest first, keyed by the last ID
/// (`_standards/14` §3.3), with the unread count for the badge.
abstract class NotificationPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  NotificationPage._({
    required this.items,
    required this.unreadCount,
  });

  factory NotificationPage({
    required List<_irt10kca.AppNotification> items,
    required int unreadCount,
  }) = _NotificationPageImpl;

  factory NotificationPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return NotificationPage(
      items: _irbavk3a.Protocol().deserialize<List<_irt10kca.AppNotification>>(
        jsonSerialization['items'],
      ),
      unreadCount: jsonSerialization['unreadCount'] as int,
    );
  }

  List<_irt10kca.AppNotification> items;

  int unreadCount;

  /// Returns a shallow copy of this [NotificationPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NotificationPage copyWith({
    List<_irt10kca.AppNotification>? items,
    int? unreadCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'unreadCount': unreadCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NotificationPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'unreadCount': unreadCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _NotificationPageImpl extends NotificationPage {
  _NotificationPageImpl({
    required List<_irt10kca.AppNotification> items,
    required int unreadCount,
  }) : super._(
         items: items,
         unreadCount: unreadCount,
       );

  /// Returns a shallow copy of this [NotificationPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NotificationPage copyWith({
    List<_irt10kca.AppNotification>? items,
    int? unreadCount,
  }) {
    return NotificationPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
