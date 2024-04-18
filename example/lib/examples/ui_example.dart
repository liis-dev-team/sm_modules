import 'dart:async';

import 'package:flutter/cupertino.dart';
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('asdads'),
                Flexible(
                  child: PaginatedListView(
                    itemBuilder: (BuildContext context, int index) {
                      return ColoredBox(color: Colors.red, child: SizedBox(height:40, child: Text('$index')));
                    },
                    itemCount: 40,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
