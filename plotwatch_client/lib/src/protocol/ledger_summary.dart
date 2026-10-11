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
import 'ledger_line.dart' as _ixc57geg;

/// A project's money at a glance (LED-04, LED-05; doc/04f M6-7, M6-8).
abstract class LedgerSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LedgerSummary._({
    required this.total,
    required this.stages,
    this.unassigned,
    required this.unaccountedAlert,
  });

  factory LedgerSummary({
    required _ixc57geg.LedgerLine total,
    required List<_ixc57geg.LedgerLine> stages,
    _ixc57geg.LedgerLine? unassigned,
    required bool unaccountedAlert,
  }) = _LedgerSummaryImpl;

  factory LedgerSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return LedgerSummary(
      total: _immd62fm.Protocol().deserialize<_ixc57geg.LedgerLine>(
        jsonSerialization['total'],
      ),
      stages: _immd62fm.Protocol().deserialize<List<_ixc57geg.LedgerLine>>(
        jsonSerialization['stages'],
      ),
      unassigned: jsonSerialization['unassigned'] == null
          ? null
          : _immd62fm.Protocol().deserialize<_ixc57geg.LedgerLine>(
              jsonSerialization['unassigned'],
            ),
      unaccountedAlert: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['unaccountedAlert'],
      ),
    );
  }

  _ixc57geg.LedgerLine total;

  /// In plan order.
  List<_ixc57geg.LedgerLine> stages;

  /// The entries tied to no stage, when there are any.
  _ixc57geg.LedgerLine? unassigned;

  /// Unaccounted above 20 % of released (LED-05).
  bool unaccountedAlert;

  /// Returns a shallow copy of this [LedgerSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LedgerSummary copyWith({
    _ixc57geg.LedgerLine? total,
    List<_ixc57geg.LedgerLine>? stages,
    _ixc57geg.LedgerLine? unassigned,
    bool? unaccountedAlert,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LedgerSummary',
      'total': total.toJson(),
      'stages': stages.toJson(valueToJson: (v) => v.toJson()),
      if (unassigned != null) 'unassigned': unassigned?.toJson(),
      'unaccountedAlert': unaccountedAlert,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LedgerSummary',
      'total': total.toJsonForProtocol(),
      'stages': stages.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (unassigned != null) 'unassigned': unassigned?.toJsonForProtocol(),
      'unaccountedAlert': unaccountedAlert,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LedgerSummaryImpl extends LedgerSummary {
  _LedgerSummaryImpl({
    required _ixc57geg.LedgerLine total,
    required List<_ixc57geg.LedgerLine> stages,
    _ixc57geg.LedgerLine? unassigned,
    required bool unaccountedAlert,
  }) : super._(
         total: total,
         stages: stages,
         unassigned: unassigned,
         unaccountedAlert: unaccountedAlert,
       );

  /// Returns a shallow copy of this [LedgerSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LedgerSummary copyWith({
    _ixc57geg.LedgerLine? total,
    List<_ixc57geg.LedgerLine>? stages,
    Object? unassigned = _Undefined,
    bool? unaccountedAlert,
  }) {
    return LedgerSummary(
      total: total ?? this.total.copyWith(),
      stages: stages ?? this.stages.map((e0) => e0.copyWith()).toList(),
      unassigned: unassigned is _ixc57geg.LedgerLine?
          ? unassigned
          : this.unassigned?.copyWith(),
      unaccountedAlert: unaccountedAlert ?? this.unaccountedAlert,
    );
  }
}
