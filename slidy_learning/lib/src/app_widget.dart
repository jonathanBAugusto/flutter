import 'package:flutter/material.dart';
import 'package:slidy_learning/src/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF007989),
        accentColor: Color(0xFF007989),
      ),
      home: HomeModule(),
    );
  }
}
