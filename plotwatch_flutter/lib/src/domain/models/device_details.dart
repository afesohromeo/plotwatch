import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_details.freezed.dart';

/// The phone and app a photo was taken with (CAP-03, doc/04d).
@freezed
abstract class DeviceDetails with _$DeviceDetails {
  const factory DeviceDetails({
    /// E.g. "Google Pixel 7".
    required String model,

    /// E.g. "Android 15".
    required String osVersion,

    /// E.g. "1.0.0+1".
    required String appVersion,
  }) = _DeviceDetails;
}
