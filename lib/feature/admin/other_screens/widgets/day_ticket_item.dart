import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

class DayTicketItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(
            text: 'تذكرة رقم ',
            font: 12.sp,
            color: Colors.black,
            weight: FontWeight.bold,
            family: 'Lato',
          ),
          MainText(
            text: 'GR5454545',
            font: 12.sp,
            color: Colors.black,
            weight: FontWeight.w300,
            family: 'Lato',
          ),
        ],
      ),
    );
  }
}
