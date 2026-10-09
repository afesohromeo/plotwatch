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
import 'package:serverpod/serverpod.dart' as _is;

/// The weather on site, in a progress update (UPD-01).
enum Weather implements _is.SerializableModel {
  sunny,
  cloudy,
  rain,
  storm;

  static Weather fromJson(String name) {
    switch (name) {
      case 'sunny':
        return Weather.sunny;
      case 'cloudy':
        return Weather.cloudy;
      case 'rain':
        return Weather.rain;
      case 'storm':
        return Weather.storm;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Weather"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
