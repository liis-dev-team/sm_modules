import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final bool primary;
  final bool bold;

  const AppTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.primary = true,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        overlayColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.zero,
        ),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.grey5;
          } else if (states.contains(MaterialState.hovered)) {
            return primary ? colors.primaryLight : colors.markerRed;
          } else if (states.contains(MaterialState.pressed)) {
            return primary ? colors.primaryDark : colors.markerRed;
          }
          return primary ? colors.primary : colors.markerRed;
        }),
        textStyle: MaterialStatePropertyAll(
          AT.t.b14,
        ),
      ),
      onPressed: enabled ? () => onTap?.call() : null,
      child: Text(
        text,
        style: AT.t.button2,
      ),
    );
  }
}
