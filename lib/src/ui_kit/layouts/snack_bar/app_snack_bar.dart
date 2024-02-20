import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/buttons/small_with_icon.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';
import 'package:sm_modules/src/ui_kit/helpers/list_extension.dart';

import 'snack_bars/snacks.dart';

class AppSnackBar extends StatelessWidget {
  final AppSnack entity;

  const AppSnackBar({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 520,
            ),
            child: (entity.text?.length ?? 60) > 30
                ? _columnRow(context)
                : _rowRow(context),
          ),
        ),
      ),
    );
  }

  Widget _rowRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        20,
      ),
      child: Wrap(
        // mainAxisSize: MainAxisSize.min,
        children: [
          if (entity.text != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                entity.text!,
                style: AT.t.b16.white(context),
              ),
            ),
          if (entity.actions != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: entity.actions,
            ),
          if (entity.options != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  for (final option in entity.options!)
                    AppSmallWithIconButton(
                      text: option.text,
                      onTap: () => option.onTap(entity),
                      darkMode: true,
                    ),
                ].separate(const SizedBox(
                  width: 8,
                )),
              ),
            ),
        ],
      ),
    );
  }

  Widget _columnRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (entity.child != null) entity.child!,
          if (entity.text != null)
            Text(
              entity.text!,
              style: AT.t.b16.white(context),
            ),
          if (entity.actions != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: entity.actions,
            ),
          if (entity.options != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  for (final option in entity.options!)
                    AppSmallWithIconButton(
                      text: option.text,
                      onTap: () => option.onTap(entity),
                      darkMode: true,
                    ),
                ].separate(const SizedBox(
                  width: 8,
                )),
              ),
            ),
        ],
      ),
    );
  }
}
