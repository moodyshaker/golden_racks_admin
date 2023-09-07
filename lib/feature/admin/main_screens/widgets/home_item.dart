import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/unsubscribers_emergency_requests_screen.dart';
import '../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class HomeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: 'حسابات فى انتظار تفعيل الخطط لها',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
                MainText(
                  text: '22',
                  font: 50.sp,
                  weight: FontWeight.w700,
                  color: mainColor,
                ),
                MainText(
                  text: 'طلب جديد',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          CustomButton(
            title: 'عرض',
            color: kSecondaryColor,
            radius: 8.r,
            height: 42.h,
            width: 95.w,
            font: 16.sp,
            family: 'Lato_bold',
            textColor: Colors.white,
            withBorder: false,
            onPressed: () async {
              MagicRouter.navigateTo(
                UnSubscribersEmergencyRequestsAdminScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
