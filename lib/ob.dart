import 'dart:io';

import 'package:observer_log/observer/ob_const.dart';
import 'package:observer_log/observer/observer_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ObType {
  nav,
  log,
  err,
  blocEV,
  blocTX,
  blocER,
}

class Ob {

  // Default log function
  static Future<void> log(String? message, {ObType type = ObType.log, DateTime? time}) async {
    time ??= DateTime.now();
    File file = await ObserverProvider.op.getLog(time);
    String id = await ObserverProvider.op.getIdentity();

    StringBuffer logBuffer = StringBuffer(id);
    logBuffer.write(" ${time.toIso8601String()} ");

    switch(type) {
      case ObType.nav:
        logBuffer.write("[navigate] ");
        break;
      case ObType.log:
        logBuffer.write("[log] ");
        break;
      case ObType.err:
        logBuffer.write("[error] ");
        break;
      case ObType.blocEV:
        logBuffer.write("[BLoC ev] ");
        break;
      case ObType.blocTX:
        logBuffer.write("[BLoC tx] ");
        break;
      case ObType.blocER:
        logBuffer.write("[BLoC er] ");
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
    required String id,
    int limit = 5,
  }) async {
    SharedPreferences prefs = await ObserverProvider.op.prefs;
    prefs.setString(ObConst.PREFS_PATH, path);
    prefs.setInt(ObConst.PREFS_LIMIT, limit);
    prefs.setString(ObConst.PREFS_ID, id);
  }
}