import 'dart:convert';
import 'dart:io';

import 'package:observer_log/observer/ObserverProvider.dart';
import 'package:observer_log/observer/ob_const.dart';
import 'package:observer_log/observer/ob_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ObType {
  log,
  err,
  ev,
  tx,
}

class Ob {

  // Default log function
  static Future<void> log(String? message, {ObType type = ObType.log, DateTime? time}) async {
    time ??= DateTime.now();
    File file = await ObserverProvider.op.getLog(time);
    StringBuffer logBuffer = StringBuffer(time.toIso8601String());
    logBuffer.write(",");
    logBuffer.write(message);
    logBuffer.write("\n");
    file.writeAsStringSync(logBuffer.toString(), mode: FileMode.append);
  }

  // Get log files
  static Future<List<ObFile>> listFiles() async {
    return await ObserverProvider.op.getLogFiles();
  }

  // Apply configuration on start-up
  static void applyConfig({
    required String path,
    int limit = 5,
  }) async {
    SharedPreferences prefs = await ObserverProvider.op.prefs;
    prefs.setString(ObConst.PREFS_PATH, path);
    prefs.setInt(ObConst.PREFS_LIMIT, limit);
  }
}