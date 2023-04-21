import 'dart:async';

import 'package:encore/screens/create_account/create_account_vu.dart';
import 'package:encore/screens/login/login_vu.dart';
import 'package:encore/screens/tasks/tasks_vu.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../network/api_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = '';
  @override
  void initState() {
    token = ApiClient.authToken;
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    token.isEmpty ? LoginScreen() : TasksScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/encore-logo.png',
              scale: 3.5,
            )),
      ),
    );
  }
}
