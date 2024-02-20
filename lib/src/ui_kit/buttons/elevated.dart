import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final bool loading;
  final double? height;

  const AppElevatedButton({
    Key? key,
    required this.text,
    this.onTap,
    this.enabled = true,
    this.loading = false,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
