import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sm_modules/src/ui_kit/buttons/clickable_widget.dart';
import 'package:sm_modules/src/ui_kit/core/app_icons.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';

class DropdownSelect<T> extends StatefulWidget {
  const DropdownSelect({
    super.key,
    this.menuAnchor = Alignment.topRight,
    this.childAnchor = Alignment.bottomRight,
    this.offset = Offset.zero,
    this.barrierColor,
    this.items = const [],
    this.title,
    this.label,
    this.initialValue,
    this.onChanged,
    this.isNested = false,
    this.itemBuilder,
    this.labelBuilder,
    this.textColor,
    this.menuPadding,
    this.maxWidth,
    this.portalLabel,
  });

  final Alignment menuAnchor;
  final Alignment childAnchor;
  final Offset offset;
  final Color? barrierColor;
  final List<T> items;
  final T? initialValue;
  final String? title;
  final String? label;
  final void Function(dynamic value)? onChanged;
  final bool isNested;
  final Widget Function(dynamic item, bool current)? itemBuilder;
  final Widget Function(
    dynamic item,
  )? labelBuilder;
  final Color? textColor;
  final EdgeInsets? menuPadding;
  final double? maxWidth;
  final PortalLabel? portalLabel;

  @override
  State<DropdownSelect> createState() => _DropdownSelectState();
}

class _DropdownSelectState<T> extends State<DropdownSelect<T>> with TickerProviderStateMixin {
  final ValueNotifier<bool> _opened = ValueNotifier(false);

  late ValueNotifier<T?> _currentValue;

  AnimationController? _animationController;
  Animation<double>? _animation;
  late GlobalKey titleKey;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    titleKey = LabeledGlobalKey('title');
    _currentValue = ValueNotifier(widget.initialValue);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOutCubic,
    );
    super.initState();
  }

  void _open() {
    _opened.value = true;
    _animationController!.animateTo(1);
  }

  void _close() {
    _animationController!.animateTo(0).whenComplete(() => _opened.value = false);
  }

  double offsetForDrop() {
    if (widget.menuAnchor != Alignment.topRight &&
        widget.menuAnchor != Alignment.topLeft &&
        widget.childAnchor != Alignment.bottomRight &&
        widget.childAnchor != Alignment.bottomLeft) return 0;
    BuildContext? context = titleKey.currentContext;
    if (context == null) return 0;
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  @override
  void didUpdateWidget(DropdownSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentValue.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return ValueListenableBuilder(
      builder: (context, opened, _) {
        return ValueListenableBuilder(
          builder: (context, currentValue, _) {
            return PortalTarget(
              visible: opened,
              portalCandidateLabels: widget.portalLabel == null ? [PortalLabel.main] : [widget.portalLabel!],
              portalFollower: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _close(),
                child: const ColoredBox(color: Colors.transparent),
              ),
              child: PortalTarget(
                visible: widget.isNested ? true : opened,
                portalFollower: Visibility(
                  visible: widget.isNested ? opened : true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 386,
                      maxWidth: widget.maxWidth ?? double.infinity,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.grey2,
                          width: 1,
                        ),
                        color: colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: FadeTransition(
                        opacity: _animation!,
                        child: SizeTransition(
                          axisAlignment: 1,
                          axis: Axis.vertical,
                          sizeFactor: _animation!,
                          child: DropdownMenu<T>(
                            items: widget.items,
                            currentItem: currentValue,
                            onChanged: (value) {
                              widget.onChanged?.call(value);
                              _currentValue.value = value;
                              _close();
                            },
                            padding: widget.menuPadding,
                            itemBuilder: widget.itemBuilder,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                anchor: Aligned(
                  follower: widget.childAnchor,
                  target: widget.menuAnchor,
                  widthFactor: 1,
                  offset: widget.offset + Offset(0, offsetForDrop()),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.title?.isNotEmpty ?? false)
                      Padding(
                        key: titleKey,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                        child: Text(
                          widget.title!,
                          style: AT.t.b16.copyWith(color: colors.grey6),
                        ),
                      ),
                    // TextFormField(
                    //   autofocus: false,
                    //   focusNode: _focusNode,
                    //   controller: TextEditingController(),
                    //   decoration: InputDecoration(
                    //     // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    //       labelText: widget.labelText,
                    //       errorText: widget.errorText,
                    //       helperText: widget.helperText,
                    //       helperMaxLines: 3,
                    //       helperStyle: AT.t.caption,
                    //       fillColor: widget.enabled ? colors.white : colors.grey2,
                    //       filled: !widget.enabled,
                    //       errorStyle:
                    //       AT.t.caption.copyWith(color: theme.colorScheme.error),
                    //       // contentPadding: EdgeInsets.zero,
                    //       hoverColor: colors.grey1,
                    //       labelStyle: AT.t.b16.copyWith(color: colors.grey6),
                    //       suffixIcon: widget.suffix != null ||
                    //           widget.password ||
                    //           widget.canClear
                    //           ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.end,
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           if (widget.password)
                    //             Padding(
                    //               padding: const EdgeInsets.only(right: 2),
                    //               child: IconButton(
                    //                 splashRadius: 14,
                    //                 visualDensity: VisualDensity.compact,
                    //                 onPressed: () =>
                    //                     setState(() => _obscure = !_obscure),
                    //                 icon: Icon(
                    //                   _obscure
                    //                       ? AppIconsBold.eyeClosed
                    //                       : AppIconsBold.eye,
                    //                   size: 24,
                    //                   color: AppColorsLight.grey5,
                    //                 ),
                    //               ),
                    //             ),
                    //           if (widget.canClear &&
                    //               (_controller.text.isNotEmpty || _focus.hasFocus))
                    //             IconButton(
                    //               splashRadius: 14,
                    //               visualDensity: VisualDensity.compact,
                    //               onPressed: () {
                    //                 setState(_controller.clear);
                    //                 widget.onChanged?.call('');
                    //               },
                    //               icon: const Icon(
                    //                 Icons.close,
                    //                 size: 16,
                    //               ),
                    //             ),
                    //           if (widget.suffix != null) widget.suffix!,
                    //         ],
                    //       )
                    //           : null,
                    //       errorMaxLines: 3,
                    //       alignLabelWithHint: true,
                    //       floatingLabelBehavior: FloatingLabelBehavior.auto),
                    //   obscureText: _obscure,
                    //   obscuringCharacter: '*',
                    //   enabled: widget.enabled,
                    //   style: AT.t.b16.copyWith(
                    //     color: colors.black,
                    //   ),
                    //   onChanged: (text) => widget.onChanged?.call(text),
                    //   onTapOutside: (event) => _focus.unfocus(),
                    //   onFieldSubmitted: widget.onSubmit,
                    //   maxLines: widget.multiline ? null : 1,
                    //   expands: false,
                    //   textAlignVertical: widget.multiline
                    //       ? TextAlignVertical.top
                    //       : TextAlignVertical.center,
                    // ),
                    ClickableWidget(
                      onTap: () {
                        _open();
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              width: 1,
                              color: opened ? colors.primary : colors.grey4,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 4),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: widget.labelBuilder?.call(currentValue) ??
                                      Text(
                                        currentValue?.toString() ?? widget.label ?? '',
                                        style: AT.t.b16.copyWith(
                                            color: widget.textColor ??
                                                (currentValue == null ? colors.grey6 : colors.black)),
                                      ),
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  if (opened) {
                                    _close();
                                  } else {
                                    _open();
                                  }
                                },
                                icon: Icon(
                                  opened ? AppIcons.caretUp : AppIcons.caretDown,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          valueListenable: _currentValue,
        );
      },
      valueListenable: _opened,
    );
  }
}

class DropdownMenu<E> extends StatelessWidget {
  final List<E> items;
  final E? currentItem;
  final void Function(E value)? onChanged;
  final Widget Function(dynamic item, bool current)? itemBuilder;
  final EdgeInsets? padding;

  const DropdownMenu({
    super.key,
    required this.items,
    this.currentItem,
    this.onChanged,
    this.itemBuilder,
    this.padding,
  });

  Widget _builder(
    E item,
    BuildContext context,
  ) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            item.toString(),
            style: AT.t.b16.copyWith(color: currentItem == item ? colors.primary : colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: items.isEmpty
          ? Center(
              child: Text(
                'Ничего не найдено',
                style: AT.t.b14Bold.grey6(context),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (E item in items)
                  ClickableHoverWidget(
                    color: colors.grey1,
                    onTap: () {
                      onChanged?.call(item);
                    },
                    child: itemBuilder?.call(item, currentItem == item) ?? _builder(item, context),
                  )
              ],
            ),
    );
  }
}
