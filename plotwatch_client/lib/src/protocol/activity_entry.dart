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
import 'activity_event.dart' as _iwse5pgb;

/// A feed event with the name of who did it (FEED-01, doc/04e M5-7).
abstract class ActivityEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ActivityEntry._({
    required this.event,
    this.actorName,
  });

  factory ActivityEntry({
    required _iwse5pgb.ActivityEvent event,
    String? actorName,
  }) = _ActivityEntryImpl;

  factory ActivityEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityEntry(
      event: _immd62fm.Protocol().deserialize<_iwse5pgb.ActivityEvent>(
        jsonSerialization['event'],
      ),
      actorName: jsonSerialization['actorName'] as String?,
    );
  }

  _iwse5pgb.ActivityEvent event;

  String? actorName;

  /// Returns a shallow copy of this [ActivityEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ActivityEntry copyWith({
    _iwse5pgb.ActivityEvent? event,
    String? actorName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityEntry',
      'event': event.toJson(),
      if (actorName != null) 'actorName': actorName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityEntry',
      'event': event.toJsonForProtocol(),
      if (actorName != null) 'actorName': actorName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityEntryImpl extends ActivityEntry {
  _ActivityEntryImpl({
    required _iwse5pgb.ActivityEvent event,
    String? actorName,
  }) : super._(
         event: event,
         actorName: actorName,
       );

  /// Returns a shallow copy of this [ActivityEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ActivityEntry copyWith({
    _iwse5pgb.ActivityEvent? event,
    Object? actorName = _Undefined,
  }) {
    return ActivityEntry(
      event: event ?? this.event.copyWith(),
      actorName: actorName is String? ? actorName : this.actorName,
    );
  }
}
