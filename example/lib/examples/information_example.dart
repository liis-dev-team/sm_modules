import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class InformationTestApp extends StatelessWidget {
  const InformationTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFormExample',
      theme: AppThemes.lightThemeMobile(),
      home: Portal(
        child: Builder(
          builder: (context) {
            return AppAdaptive(
              screenSize: MediaQuery.of(context).size,
              child: const WarningExamples(),
            );
          },
        ),
      ),
    );
  }
}

class WarningExamples extends StatefulWidget {
  const WarningExamples({super.key});

  @override
  State<WarningExamples> createState() => _WarningExamplesState();
}

class _WarningExamplesState extends State<WarningExamples> {
  late final List<Widget> pages = [];
  final StreamController<Widget> _controller = StreamController();
  int pos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                pos++;
                if (pos == pages.length) pos = 0;
                print('pos: $pos');
                Widget w = pages[pos];
                _controller.sink.add(w);
              },
              child: const Icon(Icons.navigate_before_rounded,
                  color: AppColorsLight.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                pos--;
                if (pos == -1) pos = pages.length - 1;
                print('pos: $pos');
                Widget w = pages[pos];
                _controller.sink.add(w);
              },
              child: const Icon(
                Icons.navigate_next_rounded,
                color: AppColorsLight.primary,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(),
      body: StreamBuilder<Widget>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          print('Rebuild');
          if (snapshot.hasData) {
            print('${snapshot.data} ');
            return snapshot.data ?? const SizedBox();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pages.add(noProjects(
      title: 'Нет проектов',
      body: 'Для вас нет достпуных проектов',
    ));
    pages.add(noModels(
      title: 'Нет моделей',
      body: 'Для вас нет достпуных моделей',
    ));
    pages.add(noDraws(
      title: 'Нет чертежей',
      body: 'Для вас нет достпуных чертежей',
    ));
    pages.add(noIssues(
      title: 'Нет замечаний',
      body: 'Для вас нет достпуных замечаний',
    ));
    pages.add(noChecks(
      title: 'Нет чек-листов',
      body: 'Для вас нет достпуных чек-листов',
    ));

    Widget w = pages[pos];
    _controller.sink.add(w);
  }
}

Widget noProjects({required String title, required String body}) {
  String path = 'assets/images/no_available/no_projects.svg';
  return CustomInformationWidget(title: title, body: body, pathToFile: path);
}

Widget noDraws({required String title, required String body}) {
  String path = 'assets/images/no_available/no_draws.svg';
  return CustomInformationWidget(title: title, body: body, pathToFile: path);
}

Widget noIssues({required String title, required String body}) {
  String path = 'assets/images/no_available/no_issues.svg';
  return CustomInformationWidget(title: title, body: body, pathToFile: path);
}

Widget noModels({required String title, required String body}) {
  String path = 'assets/images/no_available/no_models.svg';
  return CustomInformationWidget(title: title, body: body, pathToFile: path);
}

Widget noChecks({required String title, required String body}) {
  String path = 'assets/images/no_available/no_checks.svg';
  return CustomInformationWidget(title: title, body: body, pathToFile: path);
}
