import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_unsub_model.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';

import '../../../../constants.dart';

class EmergencyUnsubTicketTechViewScreen extends StatefulWidget {
  final EmergencyPlanUnSubModel emergencyUnsub;

  const EmergencyUnsubTicketTechViewScreen({
    required this.emergencyUnsub,
  });

  @override
  State<EmergencyUnsubTicketTechViewScreen> createState() =>
      _EmergencyUnsubTicketTechViewScreenState();
}

class _EmergencyUnsubTicketTechViewScreenState
    extends State<EmergencyUnsubTicketTechViewScreen> {
  @override
  void initState() {
    super.initState();
    // HomeCubit.listenFalse(context).getEventCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
        title1: 'عرض تذكرة رقم GR27867637365',
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(width: 1.0, color: kInactiveColor),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 19.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: 'شركة امازون',
                    font: 15.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  MainText(
                    text: 'GR27867637365 رقم التذكرة ',
                    font: 15.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 27.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: MainText(
                  text: 'عطل فني ادي الي توقف العمل بالكامل',
                  font: 12.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    MainText(
                      text: 'الفني',
                      font: 12.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    MainText(
                      text: 'تخصيص فني الان',
                      font: 15.sp,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    MainText(
                      text: 'التاريخ',
                      font: 12.sp,
                      weight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    MainText(
                      text: '21-1-2023',
                      font: 15.sp,
                      weight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: MainText(
                  text: 'تفاصيل المشكلة تسجيل صوتي',
                  font: 12.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: GestureDetector(
                  onTap: () {
                    // MagicRouter.navigateTo(AddTechnicianScreen());
                  },
                  child: Container(
                    height: 56.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.h),
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(width: 1.0, color: mainColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 24.h,
                          width: 24.w,
                          child: Image.asset(
                            getAsset('play_icon'),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        MainText(
                          text: 'تشغيل الملف الصوتي الخاص بالمشكلة',
                          color: Colors.white,
                          font: 12.sp,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: MainText(
                  text: 'الصور والفيديو الخاصين بالمشكلة',
                  font: 12.sp,
                  weight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 74.h,
                    width: 74.w,
                    child: Image.asset(
                      getAsset('no_pic'),
                    ),
                  ),
                  Container(
                    height: 74.h,
                    width: 74.w,
                    child: Image.asset(
                      getAsset('no_pic'),
                    ),
                  ),
                  Container(
                    height: 74.h,
                    width: 74.w,
                    child: Image.asset(
                      getAsset('no_pic'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
