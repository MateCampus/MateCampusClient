import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class InfoObject {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static Future<String> getDeviceVersion() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      // print(info.version.toMap());
      // info.version.sdkInt
      // info.version.sdkInt
      print(info.version.sdkInt);
      // print(info.androidId);
      // print(info.brand);
      // print(info.device);
      // print(info.model);
      // print(info.product);
      // print(info.type);
      print(info.version.release);
      // print(info.version.baseOS);
      return'andriod '+info.version.release.toString()+" (SDK " +info.version.sdkInt.toString()+")";

    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      print(info.systemVersion);
      return "ios "+info.systemVersion.toString();
    } else {
      throw Exception("지원하지 않는 기기입니다");
    }
  }

  //일단은 안드로이드인지, 아이오에스인지 판단하는 용도로 쓸듯..-> 일단 안쓸듯?
  static Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfo.androidInfo;
      print(info.version.toMap());
      return info.device.toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfo.iosInfo;
      return info.systemName.toString();
    } else {
      throw Exception("지원하지 않는 기기입니다");
    }
  }
}
