import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';

enum CursorTooltipDirection {
  leftBottom,
  leftTop,
  rightBottom,
  rightTop,
  free,
}

enum CursorTooltipPosition {
  parent,
  cursor,
}

extension CursorTooltipPositionX on CursorTooltipPosition {
  bool get isParent => this == CursorTooltipPosition.parent;

  bool get isCursor => this == CursorTooltipPosition.cursor;
}

extension CursorTooltipDirectionX on CursorTooltipDirection {
  bool get isLeftBottom => this == CursorTooltipDirection.leftBottom;

  bool get isLeftTop => this == CursorTooltipDirection.leftTop;

  bool get isRightBottom => this == CursorTooltipDirection.rightBottom;

  bool get isRightTop => this == CursorTooltipDirection.rightTop;

  bool get isFree => this == CursorTooltipDirection.free;
}

enum AppearanceStyle {
  cursor,
  side,
}

extension AppearanceStyleX on AppearanceStyle {
  bool get isCursor => this == AppearanceStyle.cursor;

  bool get isSide => this == AppearanceStyle.side;
}

enum CursorTapType {
  left,
  right,
}

extension CursorTapTypeX on CursorTapType {
  bool get isLeft => this == CursorTapType.left;

  bool get isRight => this == CursorTapType.right;
}

enum AppearanceType {
  tap,
  hover,
}

extension AppearanceTypeX on AppearanceType {
  bool get isTap => this == AppearanceType.tap;

  bool get isHover => this == AppearanceType.hover;
}

enum SideTooltipDirection {
  top,
  right,
  bottom,
  left,
  free,
  vertical,
  horizontal,
}

extension SideTooltipDirectionX on SideTooltipDirection {
  bool get isTop => this == SideTooltipDirection.top;

  bool get isRight => this == SideTooltipDirection.right;

  bool get isBottom => this == SideTooltipDirection.bottom;

  bool get isLeft => this == SideTooltipDirection.left;

  bool get isFree => this == SideTooltipDirection.free;

  bool get isVertical => this == SideTooltipDirection.vertical;

  bool get isHorizontal => this == SideTooltipDirection.horizontal;
}

class CustomTooltip extends StatefulWidget {
  final Widget child;
  final Widget? contentWidget;
  final double? maxWidth;
  final double? maxHeight;
  final CursorTooltipDirection cursorDirection;
  final CursorTooltipPosition cursorTooltipPosition;
  final AppearanceStyle appearanceStyle;
  final SideTooltipDirection sideDirection;
  final AppearanceType appearanceType;
  final CursorTapType cursorTapType;
  final bool withShadows;
  final bool deleteOnTap;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool ignoreScreenEdges;
  final VoidCallback? showOverlayCallback;
  final VoidCallback? hideOverlayCallback;
  final Function(VoidCallback hideOverlay)? overlayCallback;
  final bool active;
  final Offset offset;
  final double? width;
  final double? height;
  final bool closeReverse;

  const CustomTooltip({
    Key? key,
    required this.child,
    this.contentWidget,
    this.maxWidth,
    this.maxHeight,
    this.cursorDirection = CursorTooltipDirection.free,
    this.cursorTooltipPosition = CursorTooltipPosition.cursor,
    this.appearanceStyle = AppearanceStyle.cursor,
    this.sideDirection = SideTooltipDirection.free,
    this.appearanceType = AppearanceType.hover,
    this.cursorTapType = CursorTapType.left,
    this.withShadows = true,
    this.deleteOnTap = true,
    this.padding = const EdgeInsets.all(10),
    this.backgroundColor,
    this.ignoreScreenEdges = true,
    this.showOverlayCallback,
    this.hideOverlayCallback,
    this.overlayCallback,
    this.width,
    this.height,
    this.active = true,
    this.offset = Offset.zero,
    this.closeReverse = false,
  }) : super(key: key);

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip>
    with TickerProviderStateMixin {
  late Color color = widget.backgroundColor ?? Colors.white;

  OverlayEntry? overlayEntry;

  final LayerLink _layerLink = LayerLink();
  bool isHoverOnParent = false;
  bool isHoverOnChild = false;
  Timer? timer;
  Timer? _removeTimer;
  final FocusNode _focusNode = FocusNode();

  AnimationController? _expandController;
  Animation<double>? _expandAnimation;

  ValueNotifier<Set<dynamic>> tooltipNotifier =
      ValueNotifier({Size.zero, Offset.zero});
  ValueNotifier<Size> tooltipSizeNotifier = ValueNotifier(Size.zero);
  ValueNotifier<Offset> tooltipClipOffsetNotifier = ValueNotifier(Offset.zero);

  @override
  void initState() {
    _focusNode.addListener(_focusNodeListener);
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController!,
      curve: Curves.easeInOutCubic,
    );
    super.initState();
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      hideOverlayCallback();
    }
  }

  void hideOverlayCallback() {
    if (overlayEntry == null) {
      return;
    }
    if (!mounted) {
      return;
    }
    setState(() {
      isHoverOnChild = false;
      isHoverOnParent = false;
    });
    if (widget.hideOverlayCallback != null) {
      widget.hideOverlayCallback!();
    }
    _expandController?.reverse().whenComplete(() => _removeOverlay());
  }

  @override
  void didUpdateWidget(covariant CustomTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void checkForHide() {
    try {
      timer?.cancel();
    } catch (e) {}
    timer = Timer(const Duration(milliseconds: 100), () async {
      if (!isHoverOnChild && !isHoverOnParent) {
        hideOverlayCallback();
      }
    });
  }

  void _initRemoveTimer() {
    _removeTimer?.cancel();
    _removeTimer = Timer(const Duration(seconds: 7), () {
      hideOverlayCallback();
    });
  }

  void _removeOverlay() {
    try {
      overlayEntry?.remove();
      overlayEntry = null;
    } catch (e) {}
  }

  void _showOverlay({Offset? cursorPosition}) {
    if (!widget.active) {
      return;
    }
    if (overlayEntry != null && !widget.deleteOnTap) return;
    _removeOverlay();
    overlayEntry = _createOverlayEntry(cursorPosition: cursorPosition);
    if (widget.overlayCallback != null) {
      widget.overlayCallback!(hideOverlayCallback);
    }
    Overlay.of(context).insert(overlayEntry!);
    if (widget.appearanceType.isTap && mounted) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    try {
      _expandController?.forward();
    } on TickerCanceled {}

    if (widget.showOverlayCallback != null) {
      widget.showOverlayCallback!();
    }
  }

  OverlayEntry _createOverlayEntry({Offset? cursorPosition}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var parentSize = renderBox.size;

    ValueNotifier<Size> size =
        ValueNotifier<Size>(const Size(double.infinity, double.infinity));

    final RenderBox? overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox?;
    final Size overlaySize = overlay != null ? overlay.size : Size.zero;

    final Offset parentPosition = renderBox.localToGlobal(Offset.zero);

    Offset offset = Offset.zero;

    Offset childPosition = cursorPosition ?? parentPosition + offset;
    if (widget.cursorTooltipPosition.isParent) {
      childPosition = parentPosition + offset;
    }

    CursorTooltipDirection direction = widget.cursorDirection;
    AppearanceStyle appearance = widget.appearanceStyle;
    SideTooltipDirection sideDirection = widget.sideDirection;

    Size maxSize = overlaySize;
    EdgeInsets padding = EdgeInsets.zero;

    if (appearance.isCursor) {
      if (direction.isFree) {
        final dx = childPosition.dx > overlaySize.width / 2;
        final dy = childPosition.dy > overlaySize.height / 2;
        if (dx && dy) {
          direction = CursorTooltipDirection.leftTop;
        } else if (dx && !dy) {
          direction = CursorTooltipDirection.leftBottom;
        } else if (!dx && !dy) {
          direction = CursorTooltipDirection.rightBottom;
        } else if (!dx && dy) {
          direction = CursorTooltipDirection.rightTop;
        }
      }
      switch (direction) {
        case CursorTooltipDirection.leftBottom:
          double maxWidth =
              ((widget.maxWidth ?? double.infinity) > childPosition.dx
                  ? childPosition.dx
                  : widget.maxWidth!);
          double maxHeight = ((widget.maxHeight ?? double.infinity) >
                  overlaySize.height - childPosition.dy
              ? overlaySize.height - childPosition.dy
              : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case CursorTooltipDirection.leftTop:
          double maxWidth =
              ((widget.maxWidth ?? double.infinity) > childPosition.dx
                  ? childPosition.dx
                  : widget.maxWidth!);
          double maxHeight =
              ((widget.maxHeight ?? double.infinity) > childPosition.dy
                  ? childPosition.dy
                  : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case CursorTooltipDirection.rightBottom:
          double maxWidth = ((widget.maxWidth ?? double.infinity) >
                  overlaySize.width - childPosition.dx
              ? overlaySize.width - childPosition.dx
              : widget.maxWidth!);
          double maxHeight = ((widget.maxHeight ?? double.infinity) >
                  overlaySize.height - childPosition.dy
              ? overlaySize.height - childPosition.dy
              : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case CursorTooltipDirection.rightTop:
          double maxWidth = ((widget.maxWidth ?? double.infinity) >
                  overlaySize.width - childPosition.dx
              ? overlaySize.width - childPosition.dx
              : widget.maxWidth!);
          double maxHeight =
              ((widget.maxHeight ?? double.infinity) > childPosition.dy
                  ? childPosition.dy
                  : widget.maxHeight!);
          break;
        case CursorTooltipDirection.free:
          break;
      }
    } else {
      final center =
          parentPosition + Offset(parentSize.width / 2, parentSize.height / 2);
      final dx = overlaySize.width - center.dx;
      final dy = overlaySize.height - center.dy;
      if (sideDirection.isFree) {
        double min = math.min(math.min(dx, dy), math.min(center.dx, center.dy));
        if (min == dx) {
          sideDirection = SideTooltipDirection.left;
        } else if (min == dy) {
          sideDirection = SideTooltipDirection.top;
        } else if (min == center.dx) {
          sideDirection = SideTooltipDirection.right;
        } else if (min == center.dy) {
          sideDirection = SideTooltipDirection.bottom;
        }
      }
      if (sideDirection.isVertical) {
        double min = math.min(dy, center.dy);
        if (min == dy) {
          sideDirection = SideTooltipDirection.top;
        } else if (min == center.dy) {
          sideDirection = SideTooltipDirection.bottom;
        }
      }
      if (sideDirection.isHorizontal) {
        double min = math.min(dx, center.dx);
        if (min == dx) {
          sideDirection = SideTooltipDirection.left;
        } else if (min == center.dx) {
          sideDirection = SideTooltipDirection.right;
        }
      }
      padding = const EdgeInsets.fromLTRB(10, 10, 10, 10);
      switch (sideDirection) {
        case SideTooltipDirection.left:
          childPosition = parentPosition + Offset(0, parentSize.height / 2);
          double maxWidth =
              ((widget.maxWidth ?? double.infinity) > childPosition.dx
                  ? childPosition.dx
                  : widget.maxWidth!);
          double maxHeight = ((widget.maxHeight ?? double.infinity) >
                  (dy < center.dy ? dy * 2 : center.dy * 2)
              ? (dy < center.dy ? dy * 2 : center.dy * 2)
              : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case SideTooltipDirection.right:
          childPosition =
              parentPosition + Offset(parentSize.width, parentSize.height / 2);
          double maxWidth = ((widget.maxWidth ?? double.infinity) >
                  overlaySize.width - childPosition.dx
              ? overlaySize.width - childPosition.dx
              : widget.maxWidth!);
          double maxHeight = ((widget.maxHeight ?? double.infinity) >
                  (dy < center.dy ? dy * 2 : center.dy * 2)
              ? (dy < center.dy ? dy * 2 : center.dy * 2)
              : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case SideTooltipDirection.top:
          childPosition = parentPosition + Offset(parentSize.width / 2, 0);
          double maxWidth = ((widget.maxWidth ?? double.infinity) >
                  (dx < center.dx ? dx * 2 : center.dx * 2)
              ? (dx < center.dx ? dx * 2 : center.dx * 2)
              : widget.maxWidth!);
          double maxHeight =
              ((widget.maxHeight ?? double.infinity) > childPosition.dy
                  ? childPosition.dy
                  : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case SideTooltipDirection.bottom:
          childPosition =
              parentPosition + Offset(parentSize.width / 2, parentSize.height);
          double maxWidth = ((widget.maxWidth ?? double.infinity) >
                  (dx < center.dx ? dx * 2 : center.dx * 2)
              ? (dx < center.dx ? dx * 2 : center.dx * 2)
              : widget.maxWidth!);
          double maxHeight = ((widget.maxHeight ?? double.infinity) >
                  overlaySize.height - childPosition.dy
              ? overlaySize.height - childPosition.dy
              : widget.maxHeight!);
          maxSize = Size(maxWidth, maxHeight);
          break;
        case SideTooltipDirection.free:
          break;
        case SideTooltipDirection.vertical:
          break;
        case SideTooltipDirection.horizontal:
          break;
      }
    }

    if (widget.ignoreScreenEdges) {
      maxSize = overlaySize;
    }

    if (widget.maxWidth != null) {
      maxSize = Size(widget.maxWidth!, maxSize.height);
    }
    if (widget.maxHeight != null) {
      maxSize = Size(maxSize.width, widget.maxHeight!);
    }

    Size clipSize = const Size(5, 15);

    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: widget.offset - parentPosition,
            child: TooltipSingleChildLayout(
              cursorDirection: direction,
              appearanceStyle: appearance,
              sideDirection: sideDirection,
              parentPosition: parentPosition,
              animation: _expandAnimation!,
              size: size,
              maxSize: maxSize,
              screenSize: overlaySize,
              childPosition: childPosition,
              childClipperCallback: widget.appearanceStyle.isSide
                  ? (Size childSize, Offset clipOffset) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        tooltipNotifier.value = {childSize, clipOffset};
                      });
                    }
                  : null,
              paddingFromEdges: padding,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: MouseRegion(
                  onEnter: (e) {
                    if (widget.appearanceType.isHover) {
                      setState(() {
                        isHoverOnChild = true;
                      });
                    }
                  },
                  onExit: (e) {
                    if (widget.appearanceType.isHover) {
                      setState(() {
                        isHoverOnChild = false;
                      });
                      checkForHide();
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: maxSize.width - 15,
                          maxHeight: maxSize.height - 15,
                        ),
                        width: widget.width == null ? null : widget.width! - 5,
                        height:
                            widget.height == null ? null : widget.height! - 5,
                        margin: EdgeInsets.fromLTRB(
                          appearance.isSide && sideDirection.isRight ? 5 : 0,
                          appearance.isSide && sideDirection.isBottom ? 5 : 0,
                          appearance.isSide && sideDirection.isLeft ? 5 : 0,
                          appearance.isSide && sideDirection.isTop ? 5 : 0,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: widget.withShadows
                              ? [
                                  BoxShadow(
                                    color: colors.black.withOpacity(0.4),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]
                              : [],
                        ),
                        padding: widget.padding,
                        child: content,
                      ),
                      ValueListenableBuilder(
                          valueListenable: tooltipNotifier,
                          builder: (_, value, __) {
                            double vertical = 0;
                            double horizontal = 0;
                            final tooltipIInfo = value;
                            Size childSize = tooltipIInfo.first;
                            Offset clipOf = tooltipIInfo.last;

                            if (appearance.isSide && sideDirection.isRight) {
                              clipOf = Offset(
                                  0,
                                  childSize.height / 2 +
                                      clipOf.dy -
                                      clipSize.height / 2);
                              return Positioned(
                                bottom: clipOf.dy,
                                left: clipOf.dx,
                                child: ClipPath(
                                  clipper: ArrowClipRight(),
                                  child: Container(
                                    height: 15,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: color,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (appearance.isSide && sideDirection.isLeft) {
                              clipOf = Offset(
                                  0,
                                  childSize.height / 2 +
                                      clipOf.dy -
                                      clipSize.height / 2);
                              return Positioned(
                                bottom: clipOf.dy,
                                right: 0,
                                child: ClipPath(
                                  clipper: ArrowClipLeft(),
                                  child: Container(
                                    height: 15,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: color,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (appearance.isSide && sideDirection.isTop) {
                              clipOf = Offset(
                                  childSize.width / 2 -
                                      clipOf.dx -
                                      clipSize.height / 2,
                                  0);
                              return Positioned(
                                bottom: clipOf.dy,
                                left: clipOf.dx,
                                child: ClipPath(
                                  clipper: ArrowClip(),
                                  child: Container(
                                    height: 5,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: color,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (appearance.isSide && sideDirection.isBottom) {
                              clipOf = Offset(
                                  childSize.width / 2 -
                                      clipOf.dx -
                                      clipSize.height / 2,
                                  0);
                              return Positioned(
                                top: clipOf.dy,
                                left: clipOf.dx,
                                child: ClipPath(
                                  clipper: ArrowClipBottom(),
                                  child: Container(
                                    height: 5,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: color,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // if (appearance.isSide && sideDirection.isRight)
  // ClipPath(
  // clipper: ArrowClipRight(),
  // child: Container(
  // height: 15,
  // width: 5,
  // decoration: BoxDecoration(
  // color: color,
  // ),
  // ),
  // ),

  Widget get content {
    if (widget.contentWidget != null) {
      return widget.contentWidget!;
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        child: Listener(
          // onPointerDown: (event) {
          //   if (event.kind == PointerDeviceKind.mouse &&
          //       event.buttons == kPrimaryMouseButton &&
          //       widget.appearanceType.isTap &&
          //       widget.cursorTapType.isLeft) {
          //     if (widget.closeReverse) {
          //       // setState(() {
          //       //   isHoverOnParent = false;
          //       // });
          //       // _initRemoveTimer();
          //       hideOverlayCallback();
          //       return;
          //     }
          //     setState(() {
          //       isHoverOnParent = true;
          //     });
          //     // _initRemoveTimer();
          //     _showOverlay(cursorPosition: event.position);
          //   }
          //   if (event.kind == PointerDeviceKind.mouse &&
          //       event.buttons == kSecondaryMouseButton &&
          //       widget.appearanceType.isTap &&
          //       widget.cursorTapType.isRight) {
          //     setState(() {
          //       isHoverOnParent = true;
          //     });
          //     // _initRemoveTimer();
          //     _showOverlay(cursorPosition: event.position);
          //   }
          // },
          // onSecondaryTap: () {
          //   if (widget.cursorTapType.isRight && widget.appearanceType.isTap) {
          //     setState(() {
          //       isHoverOnParent = true;
          //     });
          //     // _initRemoveTimer();
          //     _showOverlay();
          //   }
          // },
          child: GestureDetector(
            onTap: () {
              if (widget.appearanceType.isTap) {
                if (widget.closeReverse && isHoverOnParent) {
                  setState(() {
                    isHoverOnParent = false;
                  });
                  // _initRemoveTimer();
                  hideOverlayCallback();
                  return;
                }
                setState(() {
                  isHoverOnParent = true;
                });
                // _initRemoveTimer();
                _showOverlay();
              }
            },
            child: widget.child,
          ),
        ),
        onExit: (v) {
          if (widget.appearanceType.isHover) {
            setState(() {
              isHoverOnParent = false;
            });
            checkForHide();
          }
        },
        onEnter: (v) {
          if (widget.appearanceType.isHover) {
            setState(() {
              isHoverOnParent = true;
            });
            _showOverlay(cursorPosition: v.position);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _expandController?.dispose();

    timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}

typedef TSL = TooltipSingleChildLayout;

class TooltipSingleChildLayout extends StatelessWidget {
  final Widget child;
  final ValueNotifier<Size> size;
  final Size screenSize;
  final Size maxSize;
  final Offset parentPosition;
  final Offset childPosition;
  final Function(Size childSize, Offset clipOffset)? childClipperCallback;
  final Animation<double> animation;
  final CursorTooltipDirection cursorDirection;
  final AppearanceStyle appearanceStyle;
  final SideTooltipDirection sideDirection;
  final EdgeInsets paddingFromEdges;

  const TooltipSingleChildLayout({
    Key? key,
    required this.child,
    required this.size,
    required this.maxSize,
    required this.screenSize,
    required this.parentPosition,
    required this.childPosition,
    required this.animation,
    this.childClipperCallback,
    this.cursorDirection = CursorTooltipDirection.leftBottom,
    this.appearanceStyle = AppearanceStyle.cursor,
    this.sideDirection = SideTooltipDirection.top,
    this.paddingFromEdges = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _TooltipChildDelegate(
        size: size,
        maxSize: maxSize,
        screenSize: screenSize,
        parentPosition: parentPosition,
        childClipperCallback: childClipperCallback,
        childPosition: childPosition,
        cursorDirection: cursorDirection,
        appearanceStyle: appearanceStyle,
        sideDirection: sideDirection,
        paddingFromEdges: paddingFromEdges,
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(animation),
          child: Material(
            // elevation: 4,
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _TooltipChildDelegate extends SingleChildLayoutDelegate {
  final ValueNotifier<Size> size;
  final Size screenSize;
  final Size maxSize;
  final Offset parentPosition;
  final Offset childPosition;
  final Function(Size childSize, Offset clipOffset)? childClipperCallback;
  final CursorTooltipDirection cursorDirection;
  final AppearanceStyle appearanceStyle;
  final SideTooltipDirection sideDirection;
  final EdgeInsets paddingFromEdges;

  _TooltipChildDelegate({
    required this.size,
    required this.maxSize,
    required this.screenSize,
    required this.parentPosition,
    required this.childPosition,
    this.childClipperCallback,
    this.cursorDirection = CursorTooltipDirection.leftBottom,
    this.appearanceStyle = AppearanceStyle.cursor,
    this.sideDirection = SideTooltipDirection.top,
    this.paddingFromEdges = EdgeInsets.zero,
  }) : super(relayout: size);

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(screenSize.width, screenSize.height);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.copyWith(
        maxHeight: maxSize.height, maxWidth: maxSize.width);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final offset = moveTop(childSize);
    final offset2 = edgeDetect(childSize, size);
    if (childClipperCallback != null) {
      childClipperCallback!(childSize, offset2);
    }
    return childPosition + offset + offset2;
  }

  Offset moveTop(Size childSize) {
    if (appearanceStyle.isCursor) {
      switch (cursorDirection) {
        case CursorTooltipDirection.leftBottom:
          return Offset(-childSize.width, 0);
        case CursorTooltipDirection.leftTop:
          return Offset(-childSize.width, -childSize.height);
        case CursorTooltipDirection.rightBottom:
          return const Offset(0, 0);
        case CursorTooltipDirection.rightTop:
          return Offset(0, -childSize.height);
        case CursorTooltipDirection.free:
          break;
      }
    } else {
      switch (sideDirection) {
        case SideTooltipDirection.left:
          return Offset(-childSize.width, -childSize.height / 2);
        case SideTooltipDirection.right:
          return Offset(0, -childSize.height / 2);
        case SideTooltipDirection.top:
          return Offset(-childSize.width / 2, -childSize.height);
        case SideTooltipDirection.bottom:
          return Offset(-childSize.width / 2, 0);
        case SideTooltipDirection.free:
          break;
        case SideTooltipDirection.vertical:
          break;
        case SideTooltipDirection.horizontal:
          break;
      }
    }

    return Offset.zero;
  }

  Offset edgeDetect(Size childSize, Size allSize) {
    if (appearanceStyle.isSide) {
      switch (sideDirection) {
        case SideTooltipDirection.left:
        case SideTooltipDirection.right:
          Offset offsetPos =
              childPosition + Offset(-childSize.width, -childSize.height / 2);
          double dy = 0;
          if (offsetPos.dy < 0 + paddingFromEdges.top) {
            dy = -offsetPos.dy + paddingFromEdges.top;
          }
          if (offsetPos.dy + childSize.height >
              allSize.height - paddingFromEdges.bottom) {
            dy = allSize.height -
                (offsetPos.dy + childSize.height + paddingFromEdges.bottom);
          }
          return Offset(0, dy);
        case SideTooltipDirection.top:
        case SideTooltipDirection.bottom:
          Offset offsetPos =
              childPosition + Offset(-childSize.width / 2, -childSize.height);
          double dx = 0;
          if (offsetPos.dx < 0 + paddingFromEdges.left) {
            dx = -offsetPos.dx + paddingFromEdges.left;
          }
          if (offsetPos.dx + childSize.width >
              allSize.width - paddingFromEdges.right) {
            dx = allSize.width -
                (offsetPos.dx + childSize.width + paddingFromEdges.right);
          }
          return Offset(dx, 0);
        case SideTooltipDirection.free:
          break;
        case SideTooltipDirection.vertical:
          break;
        case SideTooltipDirection.horizontal:
          break;
      }
    }

    return Offset.zero;
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class ArrowClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowClipLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height / 2);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowClipRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // path.moveTo(0, size.height);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowClipBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
