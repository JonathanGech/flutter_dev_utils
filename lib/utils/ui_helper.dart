import 'package:flutter/material.dart';

abstract class UiHelper {
  static EdgeInsets defPadding({double? hr, double? vr}) =>
      EdgeInsets.symmetric(
        horizontal: hr ?? 20,
        vertical: vr ?? 10,
      );
  static EdgeInsets defMargin({double? hr, double? vr}) => EdgeInsets.symmetric(
        horizontal: hr ?? 20,
        vertical: vr ?? 10,
      );
  static EdgeInsets defPaddingTop({double? top}) => EdgeInsets.only(
        top: top ?? 20,
      );
  static EdgeInsets defPaddingBottom({double? bottom}) => EdgeInsets.only(
        bottom: bottom ?? 20,
      );

  static BorderRadius radiusCircular({double? radius}) =>
      BorderRadius.circular(radius ?? 12);

  static TextStyle defTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? 'Montserrat',
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
      );

  static Widget defButton(
          {required String title,
          required VoidCallback onPressed,
          Color? backgroundColor,
          Color? textColor,
          Color? borderColor,
          double? width,
          double? height,
          double? radius,
          double? fontSize,
          FontWeight? fontWeight,
          String? fontFamily,
          Duration? animationDuration,
          TextAlign? textAlign,
          EdgeInsets? edgeInsets}) =>
      GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          width: width,
          height: height,
          duration: animationDuration ?? const Duration(milliseconds: 300),
          padding: edgeInsets ?? defPadding(),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: radiusCircular(radius: radius),
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            title,
            textAlign: textAlign,
            style: defTextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
            ),
          ),
        ),
      );
}
