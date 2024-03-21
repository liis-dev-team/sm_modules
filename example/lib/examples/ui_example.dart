import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class UIExamples extends StatefulWidget {
  const UIExamples({super.key});

  @override
  State<UIExamples> createState() => _UIExamplesState();
}

class _UIExamplesState extends State<UIExamples> {
  final StreamController<List<String>> _loadingController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 2),).then((value) => _loadingController.add(['adad', 'adadd', 'addasd']));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: Portal(
        child: Builder(builder: (context) {
          ThemeData theme = Theme.of(context);
          SMColors colors = theme.extension<SMColors>()!;
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownInput<String>(
                      label: 'label',
                      menuAnchor: Alignment.bottomRight,
                      childAnchor: Alignment.topRight,
                      itemsStream: _loadingController.stream,
                      onLoadItems: (String text) {
                        _loadingController.add(['a djadhasd', 'a d djh ahd', 'sssa dd'].where((element) => element.contains(text)).toList());
                      },
                    ),
                    DropdownInput<String>(
                      label: 'label',
                      menuAnchor: Alignment.bottomCenter,
                      isNested: true,
                      childAnchor: Alignment.topCenter,
                      textColor: colors.markerYellow,
                      itemsStream: _loadingController.stream,
                      maxWidth: 300,
                      onLoadItems: (String text) {
                        _loadingController.add(['adad', 'adadd', 'addasd'].where((element) => element.contains(text)).toList());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
