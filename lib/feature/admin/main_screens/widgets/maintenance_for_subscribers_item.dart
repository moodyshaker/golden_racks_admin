import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_unsub_model.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/emergency_unsub_ticket_view_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/technician_view_screen.dart';
import '../../../../constants.dart';
import '../../../../core/router/router.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class MaintenanceForSubscribersItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    getAsset('profile'),
                    height: 40.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    children: [
                      MainText(
                        text: 'شركة امازون',
                        font: 15.sp,
                        weight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      MainText(
                        text: 'GR566-23',
                        font: 14.sp,
                        weight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  MainText(
                    text: 'رقم التذكرة',
                    font: 15.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  MainText(
                    text: 'GR878657',
                    font: 14.sp,
                    weight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.h,
              ),
              MainText(
                text: 'الخطة المفعلة',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 27.h,
              ),
              MainText(
                text: 'الأساسية رصيد الدورى المتبقي (8 )',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.h,
              ),
              MainText(
                text: 'العطل',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 62.w,
              ),
              MainText(
                text: 'الصيانة الشهرية الدورية',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              MainText(
                text: 'العنوان',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 56.w,
              ),
              MainText(
                text: 'جدة - الحي الخامس - قطعه 200',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              MainText(
                text:
                    'تذكرة تلقائية من النظام لتحديد يوم للصيانة الدورية\nلهذا الشهر للشركة',
                font: 15.sp,
                color: Colors.redAccent,
                weight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      horizontalPadding: 8.w,
                      title: 'عرض التذكرة',
                      color: kSecondaryColor,
                      height: 50.h,
                      font: 12.sp,
                      family: 'Lato_bold',
                      textColor: Colors.white,
                      weight: FontWeight.w800,
                      withBorder: false,
                      onPressed: () async {
                        MagicRouter.navigateTo(EmergencyUnsubTicketViewScreen(
                          emergencyUnsub: EmergencyPlanUnSubModel(),
                        ));
                      },
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomButton(
                      horizontalPadding: 19.w,
                      title: 'تخصيص فني',
                      color: Colors.transparent,
                      height: 50.h,
                      font: 16.sp,
                      family: 'Lato_bold',
                      weight: FontWeight.w800,
                      textColor: Colors.black,
                      withBorder: true,
                      borderWidth: 1.0,
                      borderColor: gray_40,
                      onPressed: () async {
                        MagicRouter.navigateTo(TechnicianViewScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
