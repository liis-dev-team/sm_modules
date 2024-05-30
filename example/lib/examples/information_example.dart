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
                screenSize: MediaQuery
                    .of(context)
                    .size,
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
  late Widget _current;
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
                _current = pages[pos];
                setState(() {});
              },
              child: Icon(Icons.navigate_before_rounded,
                  color: AppColorsLight.primary),
              heroTag: "fab1",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                pos--;
                if (pos == -1) pos = pages.length - 1;
                _current = pages[pos];
                setState(() {});
              },
              child: Icon(
                Icons.navigate_next_rounded,
                color: AppColorsLight.primary,
              ),
              heroTag: "fab2",
            ),
          ),
        ],
      ),
      appBar: AppBar(),
      body: _current,
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

    _current = pages[0];
  }
}
