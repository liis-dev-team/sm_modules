import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sm_modules/sm_ui_kit.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';

class AppTextField extends StatefulWidget {
  final String? initialValue;
  final String? labelText;
  final String? errorText;
  final String? titleText;
  final String? helperText;
  final bool enabled;
  final bool autofocus;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmit;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType inputType;
  final bool password;
  final bool canClear;
  final Widget? suffix;
  final bool multiline;
  final double maxHeight;
  final double minHeight;

  const AppTextField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.errorText,
    this.titleText,
    this.onChanged,
    this.onSubmit,
    this.enabled = true,
    this.autofocus = false,
    this.suffix,
    this.inputFormatters,
    this.inputType = TextInputType.text,
    this.password = false,
    this.helperText,
    this.multiline = false,
    this.minHeight = 0,
    this.maxHeight = double.infinity,
    this.canClear = false,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  bool _obscure = false;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _controller.value = TextEditingValue(
          text: widget.initialValue!,
          selection: TextSelection(
              baseOffset: widget.initialValue!.length,
              extentOffset: widget.initialValue!.length));
    }

    if (widget.password) _obscure = true;

    super.initState();
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null) {
      _controller.value = TextEditingValue(
          text: widget.initialValue!,
          selection: TextSelection(
              baseOffset: widget.initialValue!.length,
              extentOffset: widget.initialValue!.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
            child: Text(
              widget.titleText!,
              style: AT.t.b12.copyWith(color: colors.grey6),
            ),
          ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.maxHeight,
            minHeight: widget.minHeight,
          ),
          child: TextFormField(
            autofocus: widget.autofocus,
            focusNode: _focus,
            controller: _controller,
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
                // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                labelText: widget.labelText,
                errorText: widget.errorText,
                helperText: widget.helperText,
                helperMaxLines: 3,
                helperStyle: AT.t.caption,
                fillColor: widget.enabled ? colors.white : colors.grey2,
                filled: !widget.enabled,
                errorStyle:
                    AT.t.caption.copyWith(color: theme.colorScheme.error),
                // contentPadding: EdgeInsets.zero,
                hoverColor: colors.grey1,
                labelStyle: AT.t.b16.copyWith(color: colors.grey6),
                suffixIcon: widget.suffix != null ||
                        widget.password ||
                        widget.canClear
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.password)
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: IconButton(
                                splashRadius: 14,
                                visualDensity: VisualDensity.compact,
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? AppIconsBold.eyeClosed
                                      : AppIconsBold.eye,
                                  size: 24,
                                  color: AppColorsLight.grey5,
                                ),
                              ),
                            ),
                          if (widget.canClear &&
                              (_controller.text.isNotEmpty || _focus.hasFocus))
                            IconButton(
                              splashRadius: 14,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                setState(_controller.clear);
                                widget.onChanged?.call('');
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 16,
                              ),
                            ),
                          if (widget.suffix != null) widget.suffix!,
                        ],
                      )
                    : null,
                errorMaxLines: 3,
                alignLabelWithHint: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto),
            obscureText: _obscure,
            obscuringCharacter: '*',
            enabled: widget.enabled,
            style: AT.t.b16.copyWith(
              color: colors.black,
            ),
            onChanged: (text) => widget.onChanged?.call(text),
            onTapOutside: (event) => _focus.unfocus(),
            onFieldSubmitted: widget.onSubmit,
            maxLines: widget.multiline ? null : 1,
            expands: false,
            textAlignVertical: widget.multiline
                ? TextAlignVertical.top
                : TextAlignVertical.center,
          ),
        ),
      ],
    );
  }
}
