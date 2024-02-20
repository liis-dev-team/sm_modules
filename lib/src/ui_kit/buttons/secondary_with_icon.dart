import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';

class AppSecondaryWithIconButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final bool loading;
  final double? height;
  final IconData? icon;

  const AppSecondaryWithIconButton({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.height,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.grey5;
          }
          return colors.primary;
        }),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled) || loading) {
            return colors.grey1;
          } else if (states.contains(MaterialState.pressed)) {
            return colors.primaryTooLight2;
          } else if (states.contains(MaterialState.hovered)) {
            return colors.primaryTooLight;
          }
          return colors.primaryTooLightOpacity;
        }),
      ),
      onPressed: enabled && !loading
          ? () {
              onTap?.call();
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && !loading)
            Padding(
              padding: EdgeInsets.only(right: text.isEmpty ? 0 : 12),
              child: Icon(
                icon!,
                color: enabled ? colors.primary : colors.grey5,
                size: 24,
              ),
            ),
          if (loading)
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: colors.primary,
                strokeWidth: 3,
              ),
            ),
          if (!loading)
            Text(
              text,
            ),
        ],
      ),
    );
  }
}
