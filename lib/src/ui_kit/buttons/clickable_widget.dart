import 'package:flutter/material.dart';

class ClickableWidget extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final VoidCallback? onTap;

  const ClickableWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          behavior: HitTestBehavior.opaque,
          child: child,
        ),
      );
}

class ClickableHoverWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double radius;
  final bool active;
  final Color? color;

  const ClickableHoverWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.radius = 0,
    this.active = true,
    this.color,
  }) : super(key: key);

  @override
  State<ClickableHoverWidget> createState() => _ClickableHoverWidgetState();
}

class _ClickableHoverWidgetState extends State<ClickableHoverWidget> {
  final ValueNotifier<bool> _hover = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          widget.active ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (e) {
        if (widget.active) _hover.value = true;
      },
      onExit: (e) {
        if (widget.active) _hover.value = false;
      },
      child: GestureDetector(
        onTap: widget.active ? widget.onTap : null,
        behavior: HitTestBehavior.opaque,
        child: ValueListenableBuilder(
          builder: (context, value, _) {
            return DecoratedBox(
                decoration: BoxDecoration(
                  color: value ? widget.color ?? Colors.black12 : null,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                ),
                child: widget.child);
          },
          valueListenable: _hover,
        ),
      ),
    );
  }
}
