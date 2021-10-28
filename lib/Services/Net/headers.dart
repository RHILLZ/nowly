import 'dart:io';

import 'package:nowly/Utils/device_app_details.dart';

class ReqHeaders {
  Map<String, String>? header;

  Future<Map<String, String>?> getHeader(String? contentType) async {
    header ??= {};

    final AppDeviceDetails appConfigs =
        await AppDeviceDetails().getAppDeviceDetails();

    header!["Content-Type"] = contentType ?? "application/json";
    header!["os"] = Platform.operatingSystem;

    header!["platform-version"] = Platform.version;

    if (Platform.isAndroid && appConfigs.packageInfo != null) {
      header!["buildNumber"] = appConfigs.packageInfo!.buildNumber;
      header!["packageName"] = appConfigs.packageInfo!.packageName;
      header!["app-version"] = appConfigs.packageInfo!.version;
    }

    if (Platform.isAndroid && appConfigs.deviceData != null) {
      header!["os-version"] = appConfigs.deviceData!["version.release"] ?? '';
      header!["manufacturer"] = appConfigs.deviceData!["brand"] ?? '';
      header!["model"] = appConfigs.deviceData!["model"] ?? '';
      header!["sdk"] = appConfigs.deviceData!["sdkInt"] ?? '';
    }
    if (Platform.isIOS && appConfigs.deviceData != null) {
      header!["systemName"] = appConfigs.deviceData!["systemName"] ?? '';
      header!["version"] = appConfigs.deviceData!["version"] ?? '';
      header!["name"] = appConfigs.deviceData!["name"] ?? '';
      header!["model"] = appConfigs.deviceData!["model"] ?? '';
    }

    return header;
  }
}
