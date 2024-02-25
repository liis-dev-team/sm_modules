import 'package:example/examples/auth_form_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sm_modules/sm_ui_kit.dart';
import 'package:sm_modules/src/auth_form/auth_form.dart';

void testAuthForm() {
  testWidgets('AuthForm', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(
      const AuthFormExample(),
    );

    // final loginFinder = find.widgetWithText(AppTextField, 'Логин');

    // expect(loginFinder, findsOneWidget);
  });
}
