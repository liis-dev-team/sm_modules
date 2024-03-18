import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class UIExamples extends StatelessWidget {
  const UIExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: Portal(
        child: Builder(
          builder: (context) {
            ThemeData theme = Theme.of(context);
            SMColors colors = theme.extension<SMColors>()!;
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownInput<String>(
                          label: 'label',
                          menuAnchor: Alignment.bottomRight,
                          childAnchor: Alignment.topRight,
                          items: [
                            'first',
                            'second',
                          ],
                        ),
                        DropdownInput<String>(
                          label: 'label',
                          menuAnchor: Alignment.bottomRight,
                          childAnchor: Alignment.topRight,
                          items: [
                            'first',
                            'second',
                          ],
                          textColor: colors.markerYellow,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
