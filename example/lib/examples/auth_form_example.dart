import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sm_modules/sm_auth_form.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class AuthFormExample extends StatefulWidget {
  const AuthFormExample({super.key});

  @override
  State<AuthFormExample> createState() => _AuthFormExampleState();
}

class _AuthFormExampleState extends State<AuthFormExample> {
  // This widget is the root of your application.
  final StreamController<bool> _loadingController = StreamController.broadcast();


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),).then((value) => _loadingController.add(true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: AuthPasswordResetForm(
        onEmailChanged: (value) => print(value),
        onConfirm: () => print('confirm'),
        onForgotPassword: () => print('forgot'),
        loadingStream: _loadingController.stream,
      ),
    );
  }
}