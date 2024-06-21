import 'package:flutter/material.dart';
import 'package:inforce_task/db/hive_repository.dart';
import 'package:inforce_task/inforce_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveRepository().initHive();
  runApp(const InforceApp());
}

