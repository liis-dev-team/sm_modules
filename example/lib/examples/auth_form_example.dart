import 'package:flutter/material.dart';
import 'package:sm_modules/sm_auth_form.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class AuthFormExample extends StatelessWidget {
  const AuthFormExample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: AuthForm(
        onEmailChanged: (value) => print(value),
        onConfirm: () => print('confirm'),
        onForgotPassword: () => print('forgot'),
      ),
    );
  }
}