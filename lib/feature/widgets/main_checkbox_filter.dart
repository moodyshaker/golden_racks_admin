import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class MainCheckboxFilter extends StatefulWidget {
  final Function onCheck;
  final String? content;
  final FontWeight? weight;
  final double? font;
  final double? rightCheckRightMargin;
  final Color? textColor;
  final bool leftCheckbox;
  final bool rightCheckbox;

  const MainCheckboxFilter({
    required this.onCheck,
    this.content,
    this.weight,
    this.textColor,
    this.rightCheckRightMargin,
    this.leftCheckbox = true,
    this.rightCheckbox = false,
    this.font,
  });

  @override
  State<MainCheckboxFilter> createState() => _State();
}

class _State extends State<MainCheckboxFilter> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
          setState(() {
            _value = !_value;
          });
          widget.onCheck(_value);
      },
      child: Row(
        children: [
          widget.rightCheckbox
              ? Container(
            width: 23.h,
            height: 23.h,
            margin: EdgeInsets.only(
                right: widget.rightCheckRightMargin ?? 8.w, left: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: _value ? kMainLighterColor : Colors.transparent,
              border:
              Border.all(color: _value ? kAccentColor : kBlackColor),
            ),
            child: Center(
              child: _value
                  ? const Icon(
                Icons.done,
                color: kAccentColor,
                size: 20,
              )
                  : null,
            ),
          )
              : Container(),
          widget.content != null
              ? Text(
            widget.content!,
            style: TextStyle(
              fontSize: widget.font ?? 16.sp,
              fontWeight: widget.weight ?? FontWeight.bold,
              color: widget.textColor ?? kAccentColor,
            ),
          )
              : Container(),
          widget.leftCheckbox
              ? Container(
            width: 23.h,
            height: 23.h,
            margin: EdgeInsets.only(right: 8.w, left: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: _value ? kAccentColor : Colors.transparent,
              border: Border.all(color: kAccentColor),
            ),
            child: Center(
              child: _value
                  ? const Icon(
                Icons.done,
                color: kMainLighterColor,
                size: 20,
              )
                  : null,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
