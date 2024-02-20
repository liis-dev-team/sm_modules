import 'package:flutter/material.dart';

import 'app_theme.dart';

typedef AT = AppTypographyFlexible;

class AppTypographyFlexible {
  static AppTypographyTablet? _tablet;

  static AppTypography get t {
    _tablet ??= AppTypographyTablet();
    return _tablet!;
  }
}

abstract class AppTypography {
  static const nunitoSansBlack = 'NunitoSans-Black';
  static const nunitoSansBold = 'NunitoSans-Bold';
  static const nunitoSansRegular = 'NunitoSans-Regular';

  ///titles
  TextStyle get title1 => const TextStyle();
  TextStyle get h2 => const TextStyle();
  TextStyle get h3 => const TextStyle();
  TextStyle get title4 => const TextStyle();

  ///buttons
  TextStyle get button => const TextStyle();
  TextStyle get button2 => const TextStyle();
  TextStyle get button3 => const TextStyle();

  ///heads
  TextStyle get headline => const TextStyle();
  TextStyle get subhead => const TextStyle();

  ///bodies
  TextStyle get b16 => const TextStyle();
  TextStyle get b16Bold => const TextStyle();
  TextStyle get b14 => const TextStyle();
  TextStyle get b14Bold => const TextStyle();
  TextStyle get b12 => const TextStyle();
  TextStyle get b12Bold => const TextStyle();

  ///captions
  TextStyle get caption => const TextStyle();
}

typedef ATT = AppTypographyTablet;

class AppTypographyTablet extends AppTypography {
  @override
  TextStyle title1 = const TextStyle(
    fontFamily: AppTypography.nunitoSansBlack,
    fontSize: 28,
    height: 1.1428,
  );
  @override
  TextStyle h2 = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.166,
  );
  @override
  TextStyle h3 = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  @override
  TextStyle title4 = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 20,
    height: 1.2,
  );

  @override
  TextStyle button = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 18,
    height: 1.222,
  );
  @override
  TextStyle button2 = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 14,
    height: 1.1428,
  );
  @override
  TextStyle button3 = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 12,
    height: 1.1428,
  );

  @override
  TextStyle headline = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 18,
    height: 1.2222,
  );
  @override
  TextStyle subhead = const TextStyle(
    fontFamily: AppTypography.nunitoSansBold,
    fontSize: 16,
    height: 1.25,
  );

  @override
  TextStyle b16 = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 16,
    height: 1.5,
  );
  @override
  TextStyle b16Bold = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
  @override
  TextStyle b14 = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 14,
    height: 1.428,
  );
  @override
  TextStyle b14Bold = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.428,
  );
  @override
  TextStyle b12 = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 12,
    height: 1.333,
  );
  @override
  TextStyle b12Bold = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.333,
  );

  @override
  TextStyle caption = const TextStyle(
    fontFamily: AppTypography.nunitoSansRegular,
    fontSize: 13,
    height: 1.2307,
  );
}

extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle theme(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.white);
  }

  TextStyle white(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.white);
  }

  TextStyle grey1(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey1);
  }

  TextStyle grey2(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey2);
  }

  TextStyle grey3(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey3);
  }

  TextStyle grey4(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey4);
  }

  TextStyle grey5(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey5);
  }

  TextStyle grey6(BuildContext context) {
    SMColors colors = Theme.of(context).extension<SMColors>()!;
    return copyWith(color: colors.grey6);
  }
}
