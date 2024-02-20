import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sm_modules/src/ui_kit/buttons/clickable_widget.dart';
import 'package:sm_modules/src/ui_kit/core/app_icons.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';
import 'package:sm_modules/src/ui_kit/helpers/list_extension.dart';

class DropdownInput<T> extends StatefulWidget {
  const DropdownInput({
    Key? key,
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
  }) : super(key: key);

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

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState<T> extends State<DropdownInput<T>>
    with TickerProviderStateMixin {
  final ValueNotifier<bool> _opened = ValueNotifier(false);

  late ValueNotifier<T?> _currentValue;

  AnimationController? _animationController;
  Animation<double>? _animation;
  late GlobalKey titleKey;

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
    _animationController!
        .animateTo(0)
        .whenComplete(() => _opened.value = false);
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
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return ValueListenableBuilder(
      builder: (context, opened, _) {
        return ValueListenableBuilder(
          builder: (context, currentValue, _) {
            return PortalTarget(
              visible: opened,
              portalFollower: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _close(),
                child: const ColoredBox(color: Colors.transparent),
              ),
              child: PortalTarget(
                visible: widget.isNested ? true : opened,
                portalFollower: Visibility(
                  visible: widget.isNested ? opened : true,
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
                        itemBuilder: widget.itemBuilder,
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
                    ClickableWidget(
                      onTap: () {
                        _open();
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                              width: opened ? 2 : 1,
                              color: opened ? colors.primary : colors.grey2,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 4),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child:
                                      widget.labelBuilder?.call(currentValue) ??
                                          Text(
                                            currentValue?.toString() ??
                                                widget.label ??
                                                '',
                                            style: AT.t.h3.copyWith(
                                                color: currentValue == null
                                                    ? colors.grey4
                                                    : colors.black),
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
                                  opened
                                      ? AppIcons.caretUp
                                      : AppIcons.caretDown,
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

  const DropdownMenu({
    Key? key,
    required this.items,
    this.currentItem,
    this.onChanged,
    this.itemBuilder,
  }) : super(key: key);

  Widget _builder(
    E item,
    BuildContext context,
  ) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          item.toString(),
          style: AT.t.button.copyWith(
              color: currentItem == item ? colors.primary : colors.black),
        ),
      ].separateWithPadding(const EdgeInsets.only(right: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Material(
      color: colors.white,
      elevation: 0,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.primary,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (E item in items)
                ClickableWidget(
                  onTap: () {
                    onChanged?.call(item);
                  },
                  child: itemBuilder?.call(item, currentItem == item) ??
                      _builder(item, context),
                )
            ].separate(Divider(
              height: 16,
              color: colors.grey2,
            )),
          ),
        ),
      ),
    );
  }
}
