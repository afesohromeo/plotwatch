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
import 'ledger_entry.dart' as _ivha9tke;

/// A page of a project's ledger, newest first (`_standards/14` §3.3).
abstract class LedgerPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LedgerPage._({required this.items});

  factory LedgerPage({required List<_ivha9tke.LedgerEntry> items}) =
      _LedgerPageImpl;

  factory LedgerPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return LedgerPage(
      items: _irbavk3a.Protocol().deserialize<List<_ivha9tke.LedgerEntry>>(
        jsonSerialization['items'],
      ),
    );
  }

  List<_ivha9tke.LedgerEntry> items;

  /// Returns a shallow copy of this [LedgerPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LedgerPage copyWith({List<_ivha9tke.LedgerEntry>? items});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LedgerPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LedgerPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LedgerPageImpl extends LedgerPage {
  _LedgerPageImpl({required List<_ivha9tke.LedgerEntry> items})
    : super._(items: items);

  /// Returns a shallow copy of this [LedgerPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LedgerPage copyWith({List<_ivha9tke.LedgerEntry>? items}) {
    return LedgerPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
