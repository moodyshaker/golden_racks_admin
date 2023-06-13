import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../core/localization/demo_localization.dart';

class RadioWidget extends StatelessWidget {
  final List<String>? items;
  final ValueChanged<int?>? onChange;
  final int? selectedValue;
  final String? header;

  const RadioWidget({
    this.header,
    this.items,
    required this.onChange,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding:  EdgeInsets.only(right:16.w),
        child: Text(
          header!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: Colors.grey,
          ),
        ),
      ),
      Row(children: [
        ...items!
            .map(
              (e) => Row(
                children: [
                  Radio(
                      activeColor: kMainColor,
                      value: (items!.indexOf(e) + 1),
                      groupValue: selectedValue,
                      onChanged: onChange),
                  Text(
                    demo.getTranslatedValue(e),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ]),
    ]);
  }
}
