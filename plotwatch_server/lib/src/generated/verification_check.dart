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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _iss;
import 'verification_check_name.dart' as _io670pev;

/// One check's result. [details] holds numbers only (e.g. distanceM,
/// allowedM); the app writes the sentence in the user's language
/// (doc/04d M4-7).
@_is.immutable
abstract class VerificationCheck
    implements _is.SerializableModel, _is.ProtocolSerialization {
  const VerificationCheck._({
    required this.name,
    required this.passed,
    required this.critical,
    this.details,
  });

  const factory VerificationCheck({
    required _io670pev.VerificationCheckName name,
    required bool passed,
    required bool critical,
    Map<String, String>? details,
  }) = _VerificationCheckImpl;

  factory VerificationCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return VerificationCheck(
      name: _io670pev.VerificationCheckName.fromJson(
        (jsonSerialization['name'] as String),
      ),
      passed: _is.BoolJsonExtension.fromJson(jsonSerialization['passed']),
      critical: _is.BoolJsonExtension.fromJson(jsonSerialization['critical']),
      details: jsonSerialization['details'] == null
          ? null
          : _irbavk3a.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['details'],
            ),
    );
  }

  final _io670pev.VerificationCheckName name;

  final bool passed;

  /// A failed critical check makes the capture unverified (VER-02).
  final bool critical;

  final Map<String, String>? details;

  /// Returns a shallow copy of this [VerificationCheck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VerificationCheck copyWith({
    _io670pev.VerificationCheckName? name,
    bool? passed,
    bool? critical,
    Map<String, String>? details,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is VerificationCheck &&
            (identical(
                  other.name,
                  name,
                ) ||
                other.name == name) &&
            (identical(
                  other.passed,
                  passed,
                ) ||
                other.passed == passed) &&
            (identical(
                  other.critical,
                  critical,
                ) ||
                other.critical == critical) &&
            const _iss.DeepCollectionEquality().equals(
              other.details,
              details,
            );
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      name,
      passed,
      critical,
      const _iss.DeepCollectionEquality().hash(details),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VerificationCheck',
      'name': name.toJson(),
      'passed': passed,
      'critical': critical,
      if (details != null) 'details': details?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VerificationCheck',
      'name': name.toJson(),
      'passed': passed,
      'critical': critical,
      if (details != null) 'details': details?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VerificationCheckImpl extends VerificationCheck {
  const _VerificationCheckImpl({
    required _io670pev.VerificationCheckName name,
    required bool passed,
    required bool critical,
    Map<String, String>? details,
  }) : super._(
         name: name,
         passed: passed,
         critical: critical,
         details: details,
       );

  /// Returns a shallow copy of this [VerificationCheck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VerificationCheck copyWith({
    _io670pev.VerificationCheckName? name,
    bool? passed,
    bool? critical,
    Object? details = _Undefined,
  }) {
    return VerificationCheck(
      name: name ?? this.name,
      passed: passed ?? this.passed,
      critical: critical ?? this.critical,
      details: details is Map<String, String>?
          ? details
          : this.details?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
    );
  }
}
