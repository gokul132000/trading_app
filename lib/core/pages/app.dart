
import 'package:flutter/material.dart';
import 'package:trading_app/core/pages/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}