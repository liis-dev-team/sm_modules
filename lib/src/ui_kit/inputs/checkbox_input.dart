import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/buttons/clickable_widget.dart';
import 'package:sm_modules/src/ui_kit/core/app_icons_bold.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';

class CheckBoxInput extends StatefulWidget {
  final String text;
  final bool? value;
  final bool triState;
  final Function(bool? value) onChanged;

  const CheckBoxInput({
    super.key,
    required this.text,
    this.value,
    this.triState = false,
    required this.onChanged,
  });

  @override
  State<CheckBoxInput> createState() => _CheckBoxInputState();
}

class _CheckBoxInputState extends State<CheckBoxInput> {
  bool? _state;

  @override
  void initState() {
    super.initState();
    _state = widget.value;
  }

  @override
  void didUpdateWidget(CheckBoxInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return ClickableWidget(
      onTap: () {
        _state = !(_state ?? true);
        setState(() {});
        widget.onChanged(_state);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                widget.text,
                style: AT.t.b16,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: AnimatedContainer(
                width: 20,
                height: 20,
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _state ?? true
                      ? colors.primary.withOpacity(1)
                      : colors.primary.withOpacity(0),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: !(_state ?? true)
                      ? Border.all(width: 2, color: colors.grey4)
                      : null,
                ),
                child: Center(
                  child: Icon(
                    _state == null
                        ? AppIconsBold.minus
                        : _state!
                            ? AppIconsBold.check
                            : null,
                    size: 14,
                    color: colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
