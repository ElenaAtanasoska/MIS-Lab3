import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ExactAlarmHelper {
  static Future<bool> checkExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.scheduleExactAlarm.status;
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.scheduleExactAlarm.request();
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> _isAtLeastAndroid12() async {
    return (await Platform.version.split(' ')[0].split('.')[0]).toString() == "12";
  }
}