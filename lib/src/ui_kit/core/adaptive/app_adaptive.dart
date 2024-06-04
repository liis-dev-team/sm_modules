import 'package:flutter/material.dart';

import 'adaptive_thresholds.dart';

export 'adaptive_thresholds.dart';

class AppAdaptive extends InheritedModel<AdaptiveThresholds> {
  final Size screenSize;

  const AppAdaptive({
    super.key,
    required Widget child,
    required this.screenSize,
  }) : super(child: child);

  bool get l512 => screenSize.width < 512;

  bool get l1200 => screenSize.width < 1200;

  bool get l1024 => screenSize.width < 1024;

  static AppAdaptive of(
    BuildContext context,
    AdaptiveThresholds dependencies,
  ) {
    final AppAdaptive? result = context
        .dependOnInheritedWidgetOfExactType<AppAdaptive>(aspect: dependencies);
    assert(result != null, 'No AppAdaptive found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppAdaptive oldWidget) {
    return l1200 != oldWidget.l1200 ||
        l1024 != oldWidget.l1024 ||
        l512 != oldWidget.l512;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AppAdaptive oldWidget,
    Set<AdaptiveThresholds> dependencies,
  ) {
    final l1200_ = l1200 != oldWidget.l1200 &&
        dependencies.contains(AdaptiveThresholds.l1200);
    final l1024_ = l1024 != oldWidget.l1024 &&
        dependencies.contains(AdaptiveThresholds.l1024);
    final l400_ = l512 != oldWidget.l512 &&
        dependencies.contains(AdaptiveThresholds.l512);
    return l1200_ || l1024_ || l400_;
  }
}
