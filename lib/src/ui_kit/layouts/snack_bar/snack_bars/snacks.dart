import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'snacks.freezed.dart';

@freezed
class AppSnack with _$AppSnack {
  const factory AppSnack({
    String? index,
    Widget? child,
    String? text,
    Widget? actions,
    List<SnackOption>? options,
    @Default(Duration(seconds: 3)) Duration duration,
  }) = _AppSnack;
}

class SnackOption {
  final String text;
  final Function(AppSnack snack) onTap;

  SnackOption({
    required this.text,
    required this.onTap,
  });

  SnackOption.close(void Function(AppSnack index) onClose)
      : this(
          text: 'Скрыть',
          onTap: onClose,
        );
}
