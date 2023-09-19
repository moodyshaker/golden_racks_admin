import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final String? family;
  final Color? color;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? verticalMargin;
  final double? horizontalMargin;
  final FontWeight? weight;
  final bool isTransparent;
  final bool withBorder;
  final Color? borderColor;
  final Color? textColor;
  final Color? imageColor;
  final double? width;
  final double? height;
  final double? borderWidth;
  final double? hor;
  final double? ver;
  final double? font;

  CustomButton(
      {this.onPressed,
      required this.title,
      this.radius,
      this.color,
      this.width,
      this.withBorder = true,
      this.verticalPadding,
      this.verticalMargin,
      this.borderWidth,
      this.horizontalPadding,
      this.horizontalMargin,
      this.family,
      this.weight,
      this.borderColor,
      this.hor,
      this.isTransparent = false,
      this.height,
      this.font,
      this.textColor,
      this.ver,
      this.imageColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin ?? 0.w,
            vertical: verticalMargin ?? 5.h),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0.w,
            vertical: verticalPadding ?? 5.h),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isTransparent ? Colors.transparent : color ?? kSecondaryColor,
          borderRadius: BorderRadius.circular(radius ?? 24.r),
          border: withBorder
              ? Border.all(
                  width: borderWidth ?? 1.0, color: borderColor ?? Colors.white)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor ?? kAccentColor,
                fontSize: font ?? 16.sp,
                fontFamily: family ?? 'Cairo',
                fontWeight: weight ?? FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
