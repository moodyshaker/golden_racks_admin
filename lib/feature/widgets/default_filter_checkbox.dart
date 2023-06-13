import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import '../../core/bloc/home_cubit.dart';
import '../../core/bloc/language_cubit.dart';

class DefaultCheckbox extends StatefulWidget {
  final Function onCheck;
  final String? content;
  final FontWeight? weight;
  final double? font;
  final double? rightCheckRightMargin;
  final Color? textColor;
  final bool leftCheckbox;
  final bool rightCheckbox;
  final bool mainValue;

  const DefaultCheckbox({
    required this.onCheck,
    required this.content,
    this.weight,
    this.textColor,
    this.rightCheckRightMargin,
    this.leftCheckbox = true,
    this.mainValue = false,
    this.rightCheckbox = false,
    this.font,
  });

  @override
  State<DefaultCheckbox> createState() => _DefaultCheckboxState();
}

class _DefaultCheckboxState extends State<DefaultCheckbox> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    final home = HomeCubit.get(context);
    final lang = LanguageCubit.get(context);
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
                    color: (widget.mainValue ? widget.mainValue : _value)
                        ? kMainLighterColor
                        : Colors.transparent,
                    border: Border.all(
                        color: (widget.mainValue ? widget.mainValue : _value)
                            ? kAccentColor
                            : kBlackColor),
                  ),
                  child: Center(
                    child: (widget.mainValue ? widget.mainValue : _value)
                        ? const Icon(
                            Icons.done,
                            color: kAccentColor,
                            size: 20,
                          )
                        : null,
                  ),
                )
              : Container(),
          Text(
            widget.content!,
            style: TextStyle(
              fontSize: widget.font ?? 16.sp,
              fontWeight: widget.weight ?? FontWeight.bold,
              color: widget.textColor ?? kAccentColor,
            ),
          ),
          widget.leftCheckbox
              ? Container(
                  width: 23.h,
                  height: 23.h,
                  margin: EdgeInsets.only(right: 8.w, left: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: (widget.mainValue ? widget.mainValue : _value)
                        ? kAccentColor
                        : Colors.transparent,
                    border: Border.all(color: kAccentColor),
                  ),
                  child: Center(
                    child: (widget.mainValue ? widget.mainValue : _value)
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
