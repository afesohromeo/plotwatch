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
import 'activity_entry.dart' as _iczfg34g;

/// A page of a project's feed, newest first, keyed by the last ID
/// (`_standards/14` §3.3).
abstract class ActivityPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ActivityPage._({required this.items});

  factory ActivityPage({required List<_iczfg34g.ActivityEntry> items}) =
      _ActivityPageImpl;

  factory ActivityPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityPage(
      items: _immd62fm.Protocol().deserialize<List<_iczfg34g.ActivityEntry>>(
        jsonSerialization['items'],
      ),
    );
  }

  List<_iczfg34g.ActivityEntry> items;

  /// Returns a shallow copy of this [ActivityPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ActivityPage copyWith({List<_iczfg34g.ActivityEntry>? items});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ActivityPageImpl extends ActivityPage {
  _ActivityPageImpl({required List<_iczfg34g.ActivityEntry> items})
    : super._(items: items);

  /// Returns a shallow copy of this [ActivityPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ActivityPage copyWith({List<_iczfg34g.ActivityEntry>? items}) {
    return ActivityPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
