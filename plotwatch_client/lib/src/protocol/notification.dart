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
import 'package:plotwatch_client/src/protocol/protocol.dart' as _immd62fm;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'notification_type.dart' as _igc0nsfd;

/// An in-app notification for one user (NOT-01). [payload] holds names and
/// numbers only; the app writes the sentence (`_standards/14` §2).
abstract class AppNotification
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppNotification._({
    this.id,
    required this.userId,
    this.projectId,
    required this.type,
    this.payload,
    this.readAt,
    required this.createdAt,
  });

  factory AppNotification({
    int? id,
    required _isc.UuidValue userId,
    int? projectId,
    required _igc0nsfd.NotificationType type,
    Map<String, String>? payload,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] as int?,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      projectId: jsonSerialization['projectId'] as int?,
      type: _igc0nsfd.NotificationType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      payload: jsonSerialization['payload'] == null
          ? null
          : _immd62fm.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['payload'],
            ),
      readAt: jsonSerialization['readAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['readAt']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue userId;

  int? projectId;

  _igc0nsfd.NotificationType type;

  Map<String, String>? payload;

  DateTime? readAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppNotification copyWith({
    int? id,
    _isc.UuidValue? userId,
    int? projectId,
    _igc0nsfd.NotificationType? type,
    Map<String, String>? payload,
    DateTime? readAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (projectId != null) 'projectId': projectId,
      'type': type.toJson(),
      if (payload != null) 'payload': payload?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (projectId != null) 'projectId': projectId,
      'type': type.toJson(),
      if (payload != null) 'payload': payload?.toJson(),
      if (readAt != null) 'readAt': readAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    int? id,
    required _isc.UuidValue userId,
    int? projectId,
    required _igc0nsfd.NotificationType type,
    Map<String, String>? payload,
    DateTime? readAt,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         projectId: projectId,
         type: type,
         payload: payload,
         readAt: readAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? userId,
    Object? projectId = _Undefined,
    _igc0nsfd.NotificationType? type,
    Object? payload = _Undefined,
    Object? readAt = _Undefined,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      projectId: projectId is int? ? projectId : this.projectId,
      type: type ?? this.type,
      payload: payload is Map<String, String>?
          ? payload
          : this.payload?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      readAt: readAt is DateTime? ? readAt : this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
