import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.primaryColor,
    required this.fillColor,
    required this.greyColor,
    required this.blackColor,
    required this.redColor,
    required this.borderColor,
    required this.textFieldFillColor,
    required this.dividerColor,
    required this.whiteColor,
    required this.indicatorColor,
    required this.boxBGColor,
    required this.secondaryColor,
    required this.lightGreyColor,
    required this.rectangleColor,
    required this.lightBorderColor,
    required this.errorColor,
    required this.lightPrimaryBgColor,
    required this.purpleBoxColor,
    required this.yellowBoxColor,
    required this.suggestionCardColor,
    required this.iconColor,
    required this.transparentColor,
  });

  final Color? primaryColor;
  final Color? fillColor;
  final Color? greyColor;
  final Color? blackColor;
  final Color? redColor;
  final Color? borderColor;
  final Color? textFieldFillColor;
  final Color? dividerColor;
  final Color? whiteColor;
  final Color? indicatorColor;
  final Color? boxBGColor;
  final Color? secondaryColor;
  final Color? lightGreyColor;
  final Color? rectangleColor;
  final Color? lightBorderColor;
  final Color? errorColor;
  final Color? lightPrimaryBgColor;
  final Color? purpleBoxColor;
  final Color? yellowBoxColor;
  final Color? suggestionCardColor;
  final Color? iconColor;
  final Color? transparentColor;

  // Default light theme colors (Black & White Theme)
  static const light = CustomColors(
    primaryColor: Color(0xff000000), // Fully Black
    fillColor: Color(0xffFFFFFF),
    greyColor: Color(0xff999999), // Subtext color
    blackColor: Color(0xff000000),
    redColor: Color(0xFFFF0000),
    borderColor: Color(0xFFE0E0E0), // Slightly softer border for B&W
    textFieldFillColor: Color(0xFFF5F5F5),
    dividerColor: Color(0xFFEEEEEE),
    whiteColor: Color(0xffFFFFFF),
    indicatorColor: Color(0xFF3D3D3D),
    boxBGColor: Color(0xFFFAFAFA),
    secondaryColor: Color(0xFF000000), // Also black for B&W
    lightGreyColor: Color(0xFFD9D9D9),
    rectangleColor: Color(0xFFF0F0F0),
    lightBorderColor: Color(0xFFF5F5F5),
    errorColor: Color(0xFFFF0000),
    lightPrimaryBgColor: Color(0xffF0F0F0),
    purpleBoxColor: Color(0xffDDC0FF),
    yellowBoxColor: Color(0xffF5F378),
    suggestionCardColor: Color(0xffBF00FF),
    iconColor: Color(0xff666666),
    transparentColor: Colors.transparent,
  );

  // Default dark theme colors (Black & White Theme)
  static const dark = CustomColors(
    primaryColor: Color(0xff000000),
    fillColor: Color(0xffFFFFFF),
    greyColor: Color(0xff999999), // Subtext color
    blackColor: Color(0xff000000),
    redColor: Color(0xFFFF0000),
    borderColor: Color(0xFFE0E0E0),
    textFieldFillColor: Color(0xFFF5F5F5),
    dividerColor: Color(0xFFEEEEEE),
    whiteColor: Color(0xffFFFFFF),
    indicatorColor: Color(0xFF3D3D3D),
    boxBGColor: Color(0xFFFAFAFA),
    secondaryColor: Color(0xFF000000),
    lightGreyColor: Color(0xFFD9D9D9),
    rectangleColor: Color(0xFFF0F0F0),
    lightBorderColor: Color(0xFFF5F5F5),
    errorColor: Color(0xFFFF0000),
    lightPrimaryBgColor: Color(0xffF0F0F0),
    purpleBoxColor: Color(0xffDDC0FF),
    yellowBoxColor: Color(0xffF5F378),
    suggestionCardColor: Color(0xffBF00FF),
    iconColor: Color(0xff666666),
    transparentColor: Colors.transparent,
  );

  @override
  CustomColors copyWith({
    Color? primaryColor,
    Color? fillColor,
    Color? greyColor,
    Color? blackColor,
    Color? lightBGColor,
    Color? redColor,
    Color? borderColor,
    Color? textFieldFillColor,
    Color? dividerColor,
    Color? whiteColor,
    Color? indicatorColor,
    Color? boxBGColor,
    Color? secondaryColor,
    Color? lightGreyColor,
    Color? rectangleColor,
    Color? lightBorderColor,
    Color? errorColor,
    Color? lightPrimaryBgColor,
    Color? purpleBoxColor,
    Color? yellowBoxColor,
    Color? suggestionCardColor,
    Color? iconColor,
    Color? transparentColor,
  }) {
    return CustomColors(
      primaryColor: primaryColor ?? this.primaryColor,
      fillColor: fillColor ?? this.fillColor,
      greyColor: greyColor ?? this.greyColor,
      blackColor: blackColor ?? this.blackColor,
      redColor: redColor ?? this.redColor,
      borderColor: borderColor ?? this.borderColor,
      textFieldFillColor: textFieldFillColor ?? this.textFieldFillColor,
      dividerColor: dividerColor ?? this.dividerColor,
      whiteColor: whiteColor ?? this.whiteColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      boxBGColor: boxBGColor ?? this.boxBGColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      lightGreyColor: lightGreyColor ?? this.lightGreyColor,
      rectangleColor: rectangleColor ?? this.rectangleColor,
      lightBorderColor: lightBorderColor ?? this.lightBorderColor,
      errorColor: errorColor ?? this.errorColor,
      lightPrimaryBgColor: lightPrimaryBgColor ?? this.lightPrimaryBgColor,
      purpleBoxColor: purpleBoxColor ?? this.purpleBoxColor,
      yellowBoxColor: yellowBoxColor ?? this.yellowBoxColor,
      suggestionCardColor: suggestionCardColor ?? this.suggestionCardColor,
      iconColor: iconColor ?? this.iconColor,
      transparentColor: transparentColor ?? this.transparentColor,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      fillColor: Color.lerp(fillColor, other.fillColor, t),
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blackColor: Color.lerp(blackColor, other.blackColor, t),
      redColor: Color.lerp(redColor, other.redColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      textFieldFillColor: Color.lerp(textFieldFillColor, other.textFieldFillColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t),
      boxBGColor: Color.lerp(boxBGColor, other.boxBGColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      lightGreyColor: Color.lerp(lightGreyColor, other.lightGreyColor, t),
      rectangleColor: Color.lerp(rectangleColor, other.rectangleColor, t),
      lightBorderColor: Color.lerp(lightBorderColor, other.lightBorderColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      lightPrimaryBgColor: Color.lerp(lightPrimaryBgColor, other.lightPrimaryBgColor, t),
      purpleBoxColor: Color.lerp(purpleBoxColor, other.purpleBoxColor, t),
      yellowBoxColor: Color.lerp(yellowBoxColor, other.yellowBoxColor, t),
      suggestionCardColor: Color.lerp(suggestionCardColor, other.suggestionCardColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      transparentColor: Color.lerp(transparentColor, other.transparentColor, t),
    );
  }
}

extension ThemeDataCustomColors on ThemeData {
  CustomColors get customColors {
    final customColors = extension<CustomColors>();
    if (customColors == null) {
      return CustomColors.light;
    }
    return customColors;
  }
}
