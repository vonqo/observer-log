import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:observer_log/ob.dart';
import 'package:observer_log/observer/ObserverProvider.dart';
import 'package:observer_log/observer/ob_utility.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Ob.applyConfig(path: appDocumentsDir.path, limit: 5);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _stressLog() async {
    setState(() {
      _isLoading = true;
    });
    DateTime startTime = DateTime.now();
    log('START TIME:');
    log(startTime.toIso8601String());

    for(int i = 0; i < 10; i++) {
      DateTime day = startTime.add(Duration(days: i));
      log('day: ${day.toIso8601String()}');
      for(int log = 0; log < 1000; log++) {
        Ob.log("Example of log lorem ipsum $log", time: day);
      }
      log('1000 log done');
    }

    DateTime endTime = DateTime.now();
    log('END TIME:');
    log(endTime.toIso8601String());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Observer Log'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    _stressLog();
                  },
                  child: const Text('Log Stress')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
