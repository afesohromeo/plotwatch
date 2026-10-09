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

/// Posted on a project's or user's channel when something was written, so
/// open streams look for it at once (doc/04e M5-5). Carries nothing else.
abstract class LiveSignal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LiveSignal._({required this.channel});

  factory LiveSignal({required String channel}) = _LiveSignalImpl;

  factory LiveSignal.fromJson(Map<String, dynamic> jsonSerialization) {
    return LiveSignal(channel: jsonSerialization['channel'] as String);
  }

  String channel;

  /// Returns a shallow copy of this [LiveSignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LiveSignal copyWith({String? channel});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LiveSignal',
      'channel': channel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LiveSignal',
      'channel': channel,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LiveSignalImpl extends LiveSignal {
  _LiveSignalImpl({required String channel}) : super._(channel: channel);

  /// Returns a shallow copy of this [LiveSignal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LiveSignal copyWith({String? channel}) {
    return LiveSignal(channel: channel ?? this.channel);
  }
}
