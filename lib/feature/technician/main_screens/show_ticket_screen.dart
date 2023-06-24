import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/bloc/app_cubit.dart';
import 'package:golden_racks_admin/core/bloc/home_cubit.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/ticket_item.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/attendance_and_departure_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/send_alert_to_company_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/technical_report_screen.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class ShowTicketScreen extends StatefulWidget {
  const ShowTicketScreen({Key? key}) : super(key: key);

  @override
  State<ShowTicketScreen> createState() => _ShowTicketScreenState();
}

class _ShowTicketScreenState extends State<ShowTicketScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final cubit = AppCubit.get(context);
    final home = HomeCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: TechnicianCustomScaffold(
          backgroundColor: Colors.transparent,
          hasAppbar: false,
          isHome: true,
          hasNavBar: false,
          title1: 'التذكرة رقم\n GR27867637365 ',
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w , horizontal: 10.h),
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: gray_40)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainText(
                            text: 'شركة امازون',
                            font: 15.sp,
                            weight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          MainText(
                            text: ' رقم التذكرة  GR27867637365',
                            font: 15.sp,
                            weight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h,),
                      MainText(
                        text: 'عطل فني ادي الي توقف العمل بالكامل',
                        font: 12.sp,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      SizedBox(height: 13.h,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    MainText(
                                      text: 'الفني',
                                      font: 15.sp,
                                      weight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8.w,),
                                    MainText(
                                      text: 'سامر احمد سيد',
                                      font: 15.sp,
                                      weight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    MainText(
                                      text: 'التاريخ',
                                      font: 15.sp,
                                      weight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8.w,),
                                    MainText(
                                      text: '21-1-2023',
                                      font: 15.sp,
                                      weight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.yellow,
                                ),
                                child: Center(
                                  child: MainText(
                                    text: 'عرض التفاصيل',
                                    color: Colors.black,
                                    font: 15.sp,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          MagicRouter.navigateTo(TechnicalReportScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.transparent,
                            border: Border.all(color: gray_40),
                          ),
                          child: Center(
                            child: MainText(
                              text: 'التقرير الفني',
                              color: Colors.black,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          MagicRouter.navigateTo(AttendanceAndDepartureScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.transparent,
                            border: Border.all(color: gray_40),
                          ),
                          child: Center(
                            child: MainText(
                              text: 'تسجيل الحضور والانصراف',
                              color: Colors.black,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.transparent,
                            border: Border.all(color: gray_40),
                          ),
                          child: Center(
                            child: MainText(
                              text: 'اصدار الفاتورة',
                              color: Colors.black,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          MagicRouter.navigateTo(SendAlertToCompanyScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: Colors.transparent,
                            border: Border.all(color: gray_40),
                          ),
                          child: Center(
                            child: MainText(
                              text: 'ارسال تنبيه للشركة',
                              color: Colors.black,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
