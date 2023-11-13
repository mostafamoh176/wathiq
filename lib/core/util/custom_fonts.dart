import 'package:flutter/cupertino.dart';

class FontConstant {
  static const String fontFamilt = "Cairo";
}

class FontWeightManager {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semiBold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w900;
}

class FontSize {
  static const double s15 = 15.0;
  static const double s20 = 20.0;
  static const double s25 = 25.0;
  static const double s30 = 30.0;
  static const double s35 = 35.0;
  static const double s40 = 40.0;
  static const double s42 = 42.0;
}

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  Color color,
  fontWeight,
  height,
  letterSpacing,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
    height: height,
    letterSpacing: letterSpacing,
  );
}

TextStyle getEtraLightStyle({
  double fontSize = FontSize.s15,
  required Color color,
  height = null,
  letterSpacing = null,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamilt,
    color,
    FontWeightManager.extraLight,
    height,
    letterSpacing,
  );
}

TextStyle getLightStyle({
  double fontSize = FontSize.s20,
  required Color color,
  height = null,
  letterSpacing = null,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamilt,
    color,
    FontWeightManager.light,
    height,
    letterSpacing,
  );
}

TextStyle getRegularStyle({
  double fontSize = FontSize.s25,
  required Color color,
  height = null,
  letterSpacing = null,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamilt,
    color,
    FontWeightManager.regular,
    height,
    letterSpacing,
  );
}

TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s30,
  required Color color,
  height = null,
  letterSpacing = null,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamilt,
    color,
    FontWeightManager.semiBold,
    height = null,
    letterSpacing = null,
  );
}

TextStyle getBoldStyle({
  double fontSize = FontSize.s40,
  required Color color,
  height,
  letterSpacing,
}) {
  return _getTextStyle(
    fontSize,
    FontConstant.fontFamilt,
    color,
    FontWeightManager.bold,
    letterSpacing,
    height,
  );
}
