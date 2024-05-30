import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sm_modules/sm_ui_kit.dart';

class CustomInformingWidget extends StatelessWidget {
  const CustomInformingWidget(
      {super.key,
      required this.title,
      required this.body,
      required this.pathToFile});

  final String title;
  final String body;
  final String pathToFile;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            pathToFile,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: SizedBox(
              height: 78,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AT.t.h2.copyWith(color: AppColorsLight.primary),
                  ),
                  Text(
                    body,
                    style: AT.t.b16.copyWith(
                        color: AppColorsLight.primary, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget noProjects({required String title, required String body}) {
  String path =
      'packages/sm_modules/assets/images/no_available/no_projects.svg';
  return CustomInformingWidget(title: title, body: body, pathToFile: path);
}

Widget noDraws({required String title, required String body}) {
  String path = 'packages/sm_modules/assets/images/no_available/no_draws.svg';
  return CustomInformingWidget(title: title, body: body, pathToFile: path);
}

Widget noIssues({required String title, required String body}) {
  String path = 'packages/sm_modules/assets/images/no_available/no_issues.svg';
  return CustomInformingWidget(title: title, body: body, pathToFile: path);
}

Widget noModels({required String title, required String body}) {
  String path = 'packages/sm_modules/assets/images/no_available/no_models.svg';
  return CustomInformingWidget(title: title, body: body, pathToFile: path);
}

Widget noChecks({required String title, required String body}) {
  String path = 'packages/sm_modules/assets/images/no_available/no_checks.svg';
  return CustomInformingWidget(title: title, body: body, pathToFile: path);
}
