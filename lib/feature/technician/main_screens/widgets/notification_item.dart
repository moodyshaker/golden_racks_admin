import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/core/models/notification_model.dart';

import '../../../../constants.dart';
import '../../../widgets/main_text.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  NotificationItem({
    required this.notification,
  });
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
            child: Row(
              children: [
                Expanded(
                  child: MainText(
                    text: '${notification.titlear}',
                    font: 16.sp,
                    color: Colors.black,
                    weight: FontWeight.bold,
                    family: 'Lato',
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MainText(
                      text: '${formateDateTimeToDate(notification.time!)}',
                      font: 12.sp,
                      color: gray_80,
                      weight: FontWeight.w600,
                      family: 'Lato',
                    ),
                    MainText(
                      text: '${formateDateTimeToTime(notification.time!)}',
                      font: 12.sp,
                      color: gray_80,
                      weight: FontWeight.w600,
                      family: 'Lato',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
