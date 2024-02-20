import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

@immutable
class SMColors extends ThemeExtension<SMColors> {
  const SMColors({
    required this.primaryTooLight2,
    required this.primaryTooLightOpacity,
    required this.primaryTooLight,
    required this.primaryLight,
    required this.primary,
    required this.primaryDark,
    required this.white,
    required this.black,
    required this.grey6,
    required this.grey5,
    required this.grey4,
    required this.grey3,
    required this.grey2,
    required this.grey1,
    required this.accentLight,
    required this.accentNight,
    required this.markerGreen,
    required this.markerLightGreen,
    required this.markerYellow,
    required this.markerLightYellow,
    required this.markerRed,
    required this.markerLightRed,
    required this.markerOr,
    required this.markerLightOr,
  });

  final Color primaryTooLight2;
  final Color primaryTooLightOpacity;
  final Color primaryTooLight;
  final Color primaryLight;
  final Color primary;
  final Color primaryDark;
  final Color white;
  final Color black;
  final Color grey6;
  final Color grey5;
  final Color grey4;
  final Color grey3;
  final Color grey2;
  final Color grey1;
  final Color accentLight;
  final Color accentNight;
  final Color markerGreen;
  final Color markerLightGreen;
  final Color markerYellow;
  final Color markerLightYellow;
  final Color markerRed;
  final Color markerLightRed;
  final Color markerOr;
  final Color markerLightOr;

  @override
  SMColors copyWith({
    Color? primaryTooLight2,
    Color? primaryTooLightOpacity,
    Color? primaryTooLight,
    Color? primaryLight,
    Color? primary,
    Color? primaryDark,
    Color? white,
    Color? black,
    Color? grey6,
    Color? grey5,
    Color? grey4,
    Color? grey3,
    Color? grey2,
    Color? grey1,
    Color? accentLight,
    Color? accentNight,
    Color? markerGreen,
    Color? markerLightGreen,
    Color? markerYellow,
    Color? markerLightYellow,
    Color? markerRed,
    Color? markerLightRed,
    Color? markerOr,
    Color? markerLightOr,
  }) {
    return SMColors(
      primaryTooLight2: primaryTooLight2 ?? this.primaryTooLight2,
      primaryTooLightOpacity:
          primaryTooLightOpacity ?? this.primaryTooLightOpacity,
      primaryTooLight: primaryTooLight ?? this.primaryTooLight,
      primaryLight: primaryLight ?? this.primaryLight,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      white: white ?? this.white,
      black: black ?? this.black,
      grey6: grey6 ?? this.grey6,
      grey5: grey5 ?? this.grey5,
      grey4: grey4 ?? this.grey4,
      grey3: grey3 ?? this.grey3,
      grey2: grey2 ?? this.grey2,
      grey1: grey1 ?? this.grey1,
      accentLight: accentLight ?? this.accentLight,
      accentNight: accentNight ?? this.accentNight,
      markerGreen: markerGreen ?? this.markerGreen,
      markerLightGreen: markerLightGreen ?? this.markerLightGreen,
      markerYellow: markerYellow ?? this.markerYellow,
      markerLightYellow: markerLightYellow ?? this.markerLightYellow,
      markerRed: markerRed ?? this.markerRed,
      markerLightRed: markerLightRed ?? this.markerLightRed,
      markerOr: markerOr ?? this.markerOr,
      markerLightOr: markerLightOr ?? this.markerLightOr,
    );
  }

  @override
  SMColors lerp(SMColors? other, double t) {
    if (other is! SMColors) {
      return this;
    }
    return SMColors(
      primaryTooLight2:
          Color.lerp(primaryTooLight2, other.primaryTooLight2, t)!,
      primaryTooLightOpacity:
          Color.lerp(primaryTooLightOpacity, other.primaryTooLightOpacity, t)!,
      primaryTooLight: Color.lerp(primaryTooLight, other.primaryTooLight, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      grey6: Color.lerp(grey6, other.grey6, t)!,
      grey5: Color.lerp(grey5, other.grey5, t)!,
      grey4: Color.lerp(grey4, other.grey4, t)!,
      grey3: Color.lerp(grey3, other.grey3, t)!,
      grey2: Color.lerp(grey2, other.grey2, t)!,
      grey1: Color.lerp(grey1, other.grey1, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentNight: Color.lerp(accentNight, other.accentNight, t)!,
      markerGreen: Color.lerp(markerGreen, other.markerGreen, t)!,
      markerLightGreen:
          Color.lerp(markerLightGreen, other.markerLightGreen, t)!,
      markerYellow: Color.lerp(markerYellow, other.markerYellow, t)!,
      markerLightYellow:
          Color.lerp(markerLightYellow, other.markerLightYellow, t)!,
      markerRed: Color.lerp(markerRed, other.markerRed, t)!,
      markerLightRed: Color.lerp(markerLightRed, other.markerLightRed, t)!,
      markerOr: Color.lerp(markerOr, other.markerOr, t)!,
      markerLightOr: Color.lerp(accentLight, other.markerLightOr, t)!,
    );
  }
}

class AppThemes {
  static ThemeData lightThemeMobile() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColorsLight.white,
      appBarTheme: const AppBarTheme(
        color: AppColorsLight.white,
        surfaceTintColor: AppColorsLight.white,
      ),
      extensions: const [
        SMColors(
          primaryTooLight2: AppColorsLight.primaryTooLight2,
          primaryTooLightOpacity: AppColorsLight.primaryTooLightOpacity,
          primaryTooLight: AppColorsLight.primaryTooLight,
          primaryLight: AppColorsLight.primaryLight,
          primary: AppColorsLight.primary,
          primaryDark: AppColorsLight.primaryDark,
          white: AppColorsLight.white,
          black: AppColorsLight.black,
          grey6: AppColorsLight.grey6,
          grey5: AppColorsLight.grey5,
          grey4: AppColorsLight.grey4,
          grey3: AppColorsLight.grey3,
          grey2: AppColorsLight.grey2,
          grey1: AppColorsLight.grey1,
          accentLight: AppColorsLight.accentLight,
          accentNight: AppColorsLight.accentNight,
          markerGreen: AppColorsLight.markerGreen,
          markerLightGreen: AppColorsLight.markerLightGreen,
          markerYellow: AppColorsLight.markerYellow,
          markerLightYellow: AppColorsLight.markerLightYellow,
          markerRed: AppColorsLight.markerRed,
          markerLightRed: AppColorsLight.markerLightRed,
          markerOr: AppColorsLight.markerOr,
          markerLightOr: AppColorsLight.markerLightOr,
        )
      ],
      fontFamilyFallback: const ['NunitoSans-Regular'],
      fontFamily: 'NunitoSans-Regular',
      iconTheme: const IconThemeData(
        color: AppColorsLight.grey6,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        iconColor: AppColorsLight.black,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        // contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
        // contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.grey4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.grey4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.markerRed,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        disabledBorder: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIconColor: AppColorsLight.black,
      ),
      // iconButtonTheme: IconButtonThemeData(
      //   style: ButtonStyle(
      //     side: MaterialStateProperty.all(BorderSide(width: 1, color: AppColorsLight.grey70),)
      //   ),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey5;
            }
            return AppColorsLight.white;
          }),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey2;
            } else if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.primaryLight;
            } else if (states.contains(MaterialState.hovered)) {
              return AppColorsLight.primaryDark;
            }
            return AppColorsLight.primary;
          }),
          overlayColor: MaterialStateColor.resolveWith((states) {
            return Colors.transparent;
          }),
          textStyle: MaterialStateProperty.all(
            AT.t.b16Bold,
          ),
          iconColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey5;
            }
            return AppColorsLight.white;
          }),
          // iconSize: MaterialStateProperty.all(
          //   24,
          // ),
          // padding: MaterialStateProperty.all(
          //   EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          // ),
          elevation: MaterialStateProperty.all(
            0,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(0, 48),
          ),
          maximumSize: MaterialStateProperty.all(
            const Size(double.infinity, 48),
          ),
        ),
      ),
    );
  }
}
