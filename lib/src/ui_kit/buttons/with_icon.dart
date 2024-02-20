import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';

class AppButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final bool loading;
  final IconData? icon;
  final double? height;

  const AppButtonWithIcon({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.icon,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return ElevatedButton(
      style: const ButtonStyle(),
      onPressed: enabled && !loading
          ? () {
              onTap?.call();
            }
          : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height ?? 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && !loading)
              Padding(
                padding: EdgeInsets.only(right: text.isEmpty ? 0 : 12),
                child: Icon(
                  icon!,
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
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
