import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';

class AppTextUnderlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;

  const AppTextUnderlineButton({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return colors.grey4;
            } else if (states.contains(MaterialState.pressed)) {
              return colors.primaryDark;
            }
            return colors.primary;
          }),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            AT.t.b14,
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.zero,
          )),
      onPressed: enabled
          ? () {
              onTap?.call();
            }
          : null,
      child: Text(
        text,
      ),
    );
  }
}
