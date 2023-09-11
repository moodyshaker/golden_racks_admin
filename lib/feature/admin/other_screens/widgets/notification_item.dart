import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../widgets/main_text.dart';

class NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: gray_0,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: gray_10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MainText(
              text: 'تم اضافة تذكرة عاجلة رقم التذكرة GR27867637365',
              font: 15.sp,
              color: Colors.black,
              weight: FontWeight.w500,
              family: 'Lato',
            ),
          ),
        ],
      ),
    );
  }
}
