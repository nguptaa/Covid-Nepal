import 'package:package_info/package_info.dart';

class AppInfo {
  Future<List<AppDetails>> getAppInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    List<AppDetails> appInfos = [];

    AppDetails appDetails = AppDetails(
      info.appName,
      info.packageName,
      info.version,
      info.buildNumber,
    );
    appInfos.add(appDetails);
    return appInfos;
  }
}

class AppDetails {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppDetails(this.appName, this.packageName, this.version, this.buildNumber);
}
