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
import 'activity_type.dart' as _iorr0e24;

/// One entry of a project's activity feed (FEED). Written from M2, streamed
/// to members from M5; (projectId, id) supports catch-up after a reconnect.
abstract class ActivityEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ActivityEvent._({
    this.id,
    required this.projectId,
    required this.actorId,
    required this.type,
    required this.targetType,
    this.targetId,
    this.payload,
    required this.createdAt,
  });

  factory ActivityEvent({
    int? id,
    required int projectId,
    required _isc.UuidValue actorId,
    required _iorr0e24.ActivityType type,
    required String targetType,
    int? targetId,
    Map<String, String>? payload,
    required DateTime createdAt,
  }) = _ActivityEventImpl;

  factory ActivityEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityEvent(
      id: jsonSerialization['id'] as int?,
      projectId: jsonSerialization['projectId'] as int,
      actorId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['actorId'],
      ),
      type: _iorr0e24.ActivityType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int?,
      payload: jsonSerialization['payload'] == null
          ? null
          : _immd62fm.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['payload'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int projectId;

  _isc.UuidValue actorId;

  _iorr0e24.ActivityType type;

  String targetType;

  int? targetId;

  /// Small summary so the feed renders without extra calls.
  Map<String, String>? payload;

  DateTime createdAt;

  /// Returns a shallow copy of this [ActivityEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ActivityEvent copyWith({
    int? id,
    int? projectId,
    _isc.UuidValue? actorId,
    _iorr0e24.ActivityType? type,
    String? targetType,
    int? targetId,
    Map<String, String>? payload,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityEvent',
      if (id != null) 'id': id,
      'projectId': projectId,
      'actorId': actorId.toJson(),
      'type': type.toJson(),
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (payload != null) 'payload': payload?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityEvent',
      if (id != null) 'id': id,
      'projectId': projectId,
      'actorId': actorId.toJson(),
      'type': type.toJson(),
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      if (payload != null) 'payload': payload?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityEventImpl extends ActivityEvent {
  _ActivityEventImpl({
    int? id,
    required int projectId,
    required _isc.UuidValue actorId,
    required _iorr0e24.ActivityType type,
    required String targetType,
    int? targetId,
    Map<String, String>? payload,
    required DateTime createdAt,
  }) : super._(
         id: id,
         projectId: projectId,
         actorId: actorId,
         type: type,
         targetType: targetType,
         targetId: targetId,
         payload: payload,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ActivityEvent copyWith({
    Object? id = _Undefined,
    int? projectId,
    _isc.UuidValue? actorId,
    _iorr0e24.ActivityType? type,
    String? targetType,
    Object? targetId = _Undefined,
    Object? payload = _Undefined,
    DateTime? createdAt,
  }) {
    return ActivityEvent(
      id: id is int? ? id : this.id,
      projectId: projectId ?? this.projectId,
      actorId: actorId ?? this.actorId,
      type: type ?? this.type,
      targetType: targetType ?? this.targetType,
      targetId: targetId is int? ? targetId : this.targetId,
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
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
