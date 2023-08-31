import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropMenu extends StatelessWidget {
  final List<String>? items;
  final Function(String?)? onChanged;
  final String? Function(String?)? valid;
  final String hint;
  final bool shouldBeEmpty;
  final Color? headerTextColor;
  final Function()? onTap;
  final dynamic value;
  final bool isModel;
  final Widget? prefixIcon;
  final Color? dropDownColor;
  final Color? hintColor;

  DropMenu({
    this.value,
    required this.hint,
    this.shouldBeEmpty = false,
    this.valid,
    this.dropDownColor,
    this.items,
    this.prefixIcon,
    this.onChanged,
    this.headerTextColor,
    this.onTap,
    this.isModel = false,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 100.h,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kInactiveColor),
                borderRadius: BorderRadius.circular(50.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kInactiveColor),
                borderRadius: BorderRadius.circular(50.r),
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: IconButton(
                        icon: prefixIcon!,
                        onPressed: () {},
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kInactiveColor),
                borderRadius: BorderRadius.circular(50.r),
              ),
              filled: true,
              fillColor: kAccentColor,
            ),
            selectedItemBuilder: (BuildContext ctx) => items!
                .map(
                  (e) => Text(
                    e,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                )
                .toList(),
            dropdownColor: dropDownColor ?? Colors.white,
            validator: valid,
            value: value,
            icon: Container(
              child: Image.asset(
                getAsset('arrow_down'),
                height: 13.h,
                width: 13.w,
              ),
            ),
            hint: Container(
              child: Text(
                value == null
                    ? hint
                    : isModel
                        ? value.name
                        : value,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: hintColor == null ? Colors.black : hintColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            iconEnabledColor: kAccentColor,
            isExpanded: true,
            items: items == null || items!.isEmpty || shouldBeEmpty
                ? []
                : items!
                    .map((e) => DropdownMenuItem<String>(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'IBM',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: items![items!.indexOf(e)],
                        ))
                    .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
