import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:observer_log/observer/ob_const.dart';
import 'package:observer_log/observer/ob_utility.dart';
import 'package:observer_log/observer/observer_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class ObFile {
  final File file;
  final DateTime date;

  const ObFile({
    required this.file,
    required this.date
  });

  @override
  String toString() {
    return 'ObFile{file: $file, date: $date}';
  }
}

class ObserverProvider {

  ObserverProvider._();
  static final ObserverProvider op = ObserverProvider._();

  SharedPreferences? _prefs;
  ObFile? _obFile;
  String? _identity;

  // ------------------------------------------------------------- //
  Future<SharedPreferences> get prefs async {
    if(_prefs != null) {
      return _prefs!;
    }
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ------------------------------------------------------------- //
  Future<String> _getPath() async {
    final pf = await prefs;
    String? path = pf.getString(ObConst.PREFS_PATH);

    if(path == null) {
      throw ObserverException("Observer configuration is not initialized!");
    }

    return path;
  }

  // ------------------------------------------------------------- //
  Future<int> _getLimit() async {
    final pf = await prefs;
    int? day = pf.getInt(ObConst.PREFS_LIMIT);

    if(day == null) {
      throw ObserverException("Observer configuration is not initialized!");
    }

    return day;
  }

  // ------------------------------------------------------------- //
  Future<String> getIdentity() async {
    final pf = await prefs;
    String? id = pf.getString(ObConst.PREFS_ID);
    if(id == null) {
      throw ObserverException("Observer configuration is not initialized!");
    }

    return id;
  }

  // ------------------------------------------------------------- //
  Future<File> getLog(DateTime time) async {
    if(_obFile != null) {
      if(ObUtility.isSameDay(_obFile!.date, time)) {
        return _obFile!.file;
      }
    }

    String fileName = ObUtility.getLogName(time);
    String path = await _getPath();
    File file = File('$path/$fileName');
    if(file.existsSync()) {
      _obFile = ObFile(file: file, date: time);
      return file;
    }

    file = await file.create(recursive: true);
    _obFile = ObFile(file: file, date: time);

    List<ObFile> obFiles = await getLogFiles();
    obFiles.sort((a,b) => b.date.compareTo(a.date));
    int limit = await _getLimit();

    for(int deleteIndex = limit; deleteIndex < obFiles.length; deleteIndex++) {
      if(obFiles[deleteIndex].file.existsSync()) {
        obFiles[deleteIndex].file.deleteSync();
      }
    }

    return file;
  }

  // ------------------------------------------------------------- //
  Future<List<ObFile>> getLogFiles() async {
    String path = await _getPath();
    List<ObFile> obFiles = [];
    List<FileSystemEntity> files = await Directory(path).list().toList();

    for(var fileEntity in files) {
      String name = fileEntity.path.split("/").last;
      if(ObUtility.isLogFile(name)) {
        obFiles.add(
          ObFile(
            file: fileEntity as File,
            date: ObUtility.getLogDate(name)
          )
        );
      }
    }
    return obFiles;
  }

}