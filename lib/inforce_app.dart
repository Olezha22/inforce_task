import 'package:flutter/material.dart';
import 'package:inforce_task/features/data_list/data_list.dart';
import 'package:inforce_task/themes/inforce_app_theme.dart';

class InforceApp extends StatelessWidget {
  const InforceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: inforceAppTheme,
      home: const DataListScreen(),
    );
  }
}