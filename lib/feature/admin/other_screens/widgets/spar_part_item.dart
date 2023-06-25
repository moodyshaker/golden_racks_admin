import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/unsubscribers_emergency_requests_screen.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/language_cubit.dart';
import '../../../../core/localization/demo_localization.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class SparPartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final lang = LanguageCubit.get(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainText(
                  text: 'ماتور ديناميكي',
                  font: 15.sp,
                  color: Colors.black,
                  weight: FontWeight.w500,
                  family: 'Lato',
                ),
                Container(
                  height: 28.h,
                  width: 28.w,
                  child: Image.asset(
                    getAsset('eyes_icon'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w,),
          CustomButton(
            title: 'اضافة',
            width: 90.w,
            color: mainColor,
            font: 15.sp,
            radius: 8.r,
            family: 'Lato_bold',
            weight: FontWeight.w800,
            textColor: Colors.white,
            withBorder: false,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
