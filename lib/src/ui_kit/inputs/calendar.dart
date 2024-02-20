import 'package:sm_modules/src/ui_kit/inputs/calendar_date_picker/calendar_date_picker2.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sm_modules/src/ui_kit/buttons/clickable_widget.dart';
import 'package:sm_modules/src/ui_kit/buttons/secondary.dart';
import 'package:sm_modules/src/ui_kit/buttons/with_icon.dart';
import 'package:sm_modules/src/ui_kit/core/app_theme.dart';
import 'package:sm_modules/src/ui_kit/core/app_typography.dart';
import 'package:sm_modules/src/ui_kit/helpers/vector/vector2/vector2.dart';

class CalendarInput extends StatefulWidget {
  final Function(Vector2<DateTime>? value)? onSubmitted;
  final Function() onClose;
  final Vector2<DateTime>? initial;

  const CalendarInput({
    super.key,
    this.onSubmitted,
    this.initial,
    required this.onClose,
  });

  @override
  State<CalendarInput> createState() => CalendarInputState();
}

class CalendarInputState extends State<CalendarInput> {
  final ValueNotifier<Vector2<DateTime>?> _tempDate = ValueNotifier(null);
  final ValueNotifier<bool> _resetDate = ValueNotifier(false);
  final ScrollController _firstController = ScrollController();
  final ScrollController _secondController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tempDate.value = widget.initial;
    if (widget.initial != null) {
      _resetDate.value = true;
    }
  }

  void _changeDate(Vector2<DateTime>? value) {
    _tempDate.value = value;
    _resetDate.value = false;
  }

  void _reset() {
    _tempDate.value = null;
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    ThemeData theme = Theme.of(context);
    SMColors colors = theme.extension<SMColors>()!;

    return Material(
      color: colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(4, 4),
              blurRadius: 7,
            )
          ],
          color: colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
            maxHeight: 510,
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 380,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
                        child: ValueListenableBuilder(
                            valueListenable: _tempDate,
                            builder: (context, value, _) {
                              return FutureBuilder(future: Future(() async {
                                await Future.delayed(
                                    const Duration(milliseconds: 150));
                                return true;
                              }), builder: (context, snap) {
                                if (!(snap.data ?? false)) {
                                  return const SizedBox();
                                }
                                return CalendarDatePicker2(
                                  onValueChanged: (List<DateTime?> dates) {
                                    if (dates.isEmpty) {
                                      _changeDate(null);
                                    } else if (dates.length == 1 ||
                                        dates.length == 2 &&
                                            dates[0]!.isSameDay(dates[1]!)) {
                                      _changeDate(Vector2<DateTime>(
                                          x: dates[0]!.startOfDay,
                                          y: dates[0]!.endOfDay.sub(
                                              const Duration(seconds: 1))));
                                    } else if (dates.length == 2) {
                                      _changeDate(Vector2<DateTime>(
                                          x: dates[0]!.startOfDay,
                                          y: dates[1]!.endOfDay.subtract(
                                              const Duration(
                                                  milliseconds: 1))));
                                    }
                                    return;
                                  },
                                  config: CalendarDatePicker2Config(
                                    calendarType: CalendarDatePicker2Type.range,
                                    rangeBidirectional: true,
                                    lastDate: DateTime.now(),
                                    // firstDate: DateTime.now(),
                                    // controlsHeight: 100,
                                    controlsTextStyle: AT.t.b16,
                                    modePickerTextHandler: (
                                        {required DateTime monthDate}) {
                                      return '${DateFormat(DateFormat.MONTH, 'ru').format(monthDate)} ${DateFormat(DateFormat.YEAR, 'ru').format(monthDate)}';
                                    },
                                    customModePickerIcon: Icon(
                                      Icons.chevron_right,
                                      color: colors.primary,
                                    ),
                                    centerAlignModePicker: true,
                                    weekdayLabels: [
                                      'вс',
                                      'пн',
                                      'вт',
                                      'ср',
                                      'чт',
                                      'пт',
                                      'сб',
                                    ],
                                    weekdayLabelTextStyle:
                                        AT.t.b16.copyWith(color: colors.grey5),
                                    selectedDayHighlightColor: colors.primary,
                                    dayTextStyle: AT.t.b16,
                                    selectedDayTextStyle:
                                        AT.t.b16.copyWith(color: colors.white),
                                    firstDayOfWeek: 1,
                                    dayBuilder: ({
                                      required DateTime date,
                                      BoxDecoration? decoration,
                                      bool? isDisabled,
                                      bool? isOverRanged,
                                      bool? isSelected,
                                      bool? isToday,
                                      TextStyle? textStyle,
                                    }) {
                                      if ((isToday ?? false) &&
                                          !(isSelected ?? false)) {
                                        return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Stack(
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  date.day.toString(),
                                                  style: textStyle,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  // margin: const EdgeInsets.only(top: 2),
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: colors.primary,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                      return DecoratedBox(
                                        decoration:
                                            decoration ?? const BoxDecoration(),
                                        child: Center(
                                          child: Text(
                                            date.day.toString(),
                                            style: textStyle?.copyWith(
                                                color: date.isWeekend &&
                                                        !((isSelected ??
                                                                false) ||
                                                            (isOverRanged ??
                                                                false) ||
                                                            (isDisabled ??
                                                                false))
                                                    ? colors.primary
                                                    : textStyle.color),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  value: value != null
                                      ? value.x!.isSameDay(value.y!)
                                          ? [value.x!]
                                          : [value.x, value.y]
                                      : [],
                                );
                              });
                              return const SizedBox.expand();
                            }),
                      ),
                    ),
                    // SizedBox(height: 32,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 10),
                      child: Row(
                        children: [
                          ClickableWidget(
                            onTap: () {
                              _changeDate(Vector2(
                                x: DateTime.now().startOfDay,
                                y: DateTime.now()
                                    .endOfDay
                                    .sub(const Duration(seconds: 1)),
                              ));
                            },
                            child: Text(
                              'Сегодня',
                              style: AT.t.b16Bold.copyWith(color: colors.grey5),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: colors.grey3,
                height: 1,
                thickness: 1,
              ),
              const SizedBox(
                height: 24,
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ValueListenableBuilder(
                      valueListenable: _tempDate,
                      builder: (context, value, _) {
                        String dateX = '';
                        String dateY = '';
                        if (value != null) {
                          dateX = localizations.formatFullDate(value.x!);
                          dateX = dateX.split(',')[1];
                          dateX = dateX.substring(0, dateX.length - 3);
                          dateY = localizations.formatFullDate(value.y!);
                          dateY = dateY.split(',')[1];
                          dateY = dateY.substring(0, dateY.length - 3);
                        }
                        return Text(
                          value == null
                              ? ''
                              : value.x!.isSameDay(value.y!)
                                  ? dateX
                                  : '$dateX - $dateY',
                          style: AT.t.h3,
                        );
                      }),
                ),
              ),
              Flexible(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: _resetDate,
                            builder: (context, reset, _) {
                              if (reset) {
                                return AppSecondaryButton(
                                  onTap: () {
                                    _reset();
                                  },
                                  text: 'Сбросить',
                                );
                              }
                              return AppSecondaryButton(
                                onTap: () {
                                  widget.onClose();
                                },
                                text: 'Отмена',
                              );
                            }),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: _tempDate,
                            builder: (context, value, _) {
                              return AppButtonWithIcon(
                                onTap: () {
                                  widget.onSubmitted?.call(value);
                                  widget.onClose();
                                },
                                text: 'Выбрать',
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
