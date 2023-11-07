import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/technical_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/screens/technical_profile_screen.dart';
import '../../../../constants.dart';
import '../../../widgets/main_text.dart';

class TechnicianItem extends StatelessWidget {
  final Technical tech;

  const TechnicianItem({
    required this.tech,
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
          MainText(
            text: '${tech.fullName}',
            font: 15.sp,
            color: Colors.black,
            weight: FontWeight.w500,
            family: 'Lato',
          ),
          InkWell(
            child: Container(
              height: 28.h,
              width: 28.w,
              child: Image.asset(
                getAsset('eyes_icon'),
              ),
            ),
            onTap: () {
              MagicRouter.navigateTo(
                TechProfileScreen(
                  techId: tech.userId!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
