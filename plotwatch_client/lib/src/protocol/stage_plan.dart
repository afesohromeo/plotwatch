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
import 'stage_view.dart' as _iobwm8xj;

/// A project's stages in order, with the total budget (BUD-01) and the
/// progress (STG-09, doc/04c M3-10). Not paginated: at most 50 stages.
abstract class StagePlan
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StagePlan._({
    required this.stages,
    required this.budgetTotalMinor,
    required this.progressPercent,
  });

  factory StagePlan({
    required List<_iobwm8xj.StageView> stages,
    required int budgetTotalMinor,
    required int progressPercent,
  }) = _StagePlanImpl;

  factory StagePlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return StagePlan(
      stages: _immd62fm.Protocol().deserialize<List<_iobwm8xj.StageView>>(
        jsonSerialization['stages'],
      ),
      budgetTotalMinor: jsonSerialization['budgetTotalMinor'] as int,
      progressPercent: jsonSerialization['progressPercent'] as int,
    );
  }

  List<_iobwm8xj.StageView> stages;

  /// Sum of the stage budgets, in minor units.
  int budgetTotalMinor;

  /// 0–100, the budget-weighted share of approved stages.
  int progressPercent;

  /// Returns a shallow copy of this [StagePlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StagePlan copyWith({
    List<_iobwm8xj.StageView>? stages,
    int? budgetTotalMinor,
    int? progressPercent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StagePlan',
      'stages': stages.toJson(valueToJson: (v) => v.toJson()),
      'budgetTotalMinor': budgetTotalMinor,
      'progressPercent': progressPercent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StagePlan',
      'stages': stages.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'budgetTotalMinor': budgetTotalMinor,
      'progressPercent': progressPercent,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _StagePlanImpl extends StagePlan {
  _StagePlanImpl({
    required List<_iobwm8xj.StageView> stages,
    required int budgetTotalMinor,
    required int progressPercent,
  }) : super._(
         stages: stages,
         budgetTotalMinor: budgetTotalMinor,
         progressPercent: progressPercent,
       );

  /// Returns a shallow copy of this [StagePlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StagePlan copyWith({
    List<_iobwm8xj.StageView>? stages,
    int? budgetTotalMinor,
    int? progressPercent,
  }) {
    return StagePlan(
      stages: stages ?? this.stages.map((e0) => e0.copyWith()).toList(),
      budgetTotalMinor: budgetTotalMinor ?? this.budgetTotalMinor,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }
}
