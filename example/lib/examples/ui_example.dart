import 'package:flutter/material.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class UIExamples extends StatelessWidget {
  const UIExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField(
              items: [],
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
