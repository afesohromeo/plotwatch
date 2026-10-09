import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// The phone's model, OS and the app version, sent with each photo
/// (CAP-03, doc/04d). Behind a class so BLoC tests don't need the plugins.
class DeviceInfoProvider {
  const DeviceInfoProvider();

  Future<DeviceDetails> details() async {
    final package = await PackageInfo.fromPlatform();
    final appVersion = '${package.version}+${package.buildNumber}';
    final info = DeviceInfoPlugin();
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final android = await info.androidInfo;
      return DeviceDetails(
        model: '${android.manufacturer} ${android.model}',
        osVersion: 'Android ${android.version.release}',
        appVersion: appVersion,
      );
    }
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      final ios = await info.iosInfo;
      return DeviceDetails(
        model: ios.utsname.machine,
        osVersion: '${ios.systemName} ${ios.systemVersion}',
        appVersion: appVersion,
      );
    }
    return DeviceDetails(
      model: 'Unknown',
      osVersion: defaultTargetPlatform.name,
      appVersion: appVersion,
    );
  }
}
