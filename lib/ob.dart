import 'dart:io';

import 'package:observer_log/observer/ob_const.dart';
import 'package:observer_log/observer/observer_provider.dart';
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

    switch(type) {
      case ObType.log:
        logBuffer.write("[LOG] ");
        break;
      case ObType.err:
        logBuffer.write("[ERROR] ");
        break;
      case ObType.ev:
        logBuffer.write("[EVENT] ");
        break;
      case ObType.tx:
        logBuffer.write("[TXN] ");
        break;
    }

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