import 'package:corporita_task/core/local_database/hive.dart';
import 'package:corporita_task/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveHelper.initHive();
  runApp(
    const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      title: 'Corporatica task',
    ),
  );
}
