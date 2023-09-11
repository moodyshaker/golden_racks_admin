import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_company_with_plan_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

import '../../../../constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class SharedCompanyDataScreen extends StatefulWidget {
  const SharedCompanyDataScreen({Key? key}) : super(key: key);

  @override
  State<SharedCompanyDataScreen> createState() =>
      _SharedCompanyDataScreenState();
}

class _SharedCompanyDataScreenState extends State<SharedCompanyDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
        title1: 'بيانات الشركات المشتركة',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  log('from shareCompanyDataScreen');

                  MagicRouter.navigateTo(AddCompanyWithPlanScreen());
                },
                child: Container(
                  height: 56.h,
                  width: 200.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.h),
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(width: 1.0, color: mainColor),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 32.h,
                        width: 32.w,
                        child: Image.asset(
                          getAsset('add_icon'),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      MainText(
                        text: 'اضافة شركة',
                        color: Colors.white,
                        font: 16.sp,
                        weight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                child: CustomTextField(
                  borderColor: mainColor,
                  hint: 'ابحث عن شركة',
                  horizontalPadding: 16.w,
                  suffixIcon: Container(
                    width: 60.w,
                    child: Center(
                        child: Container(
                      height: 32.h,
                      width: 32.w,
                      child: Image.asset(getAsset('search_icon')),
                    )),
                  ),
                  hasHint: true,
                  suffixCallback: () {},
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                title: 'اسم الشركة',
                color: backColor,
                height: 50.h,
                font: 15.sp,
                radius: 8.r,
                family: 'Lato_bold',
                weight: FontWeight.w800,
                textColor: Colors.black,
                withBorder: false,
                onPressed: () async {},
              ),
              SizedBox(
                height: 6.h,
              ),
              Container(
                height: 235.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemBuilder: (BuildContext context, int i) =>
                      TechnicianItem(),
                  itemCount: 4,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
