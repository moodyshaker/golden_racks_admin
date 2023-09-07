import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/technician_view_screen.dart';
import '../../../../constants.dart';
import '../../../../core/router/router.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';
import '../../other_screens/ticket_view_screen.dart';

class SubscribersRequestsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 9.w,
          ),
          Row(
            children: [
              // Container(
              //   height: 38.h,
              //   width: 38.w,
              //   child: Image.asset(
              //     getAsset('defualt_pic'),
              //   ),
              // ),
              SizedBox(
                width: 9.w,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              ),
            ],
          ),
          SizedBox(
            width: 9.w,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              MainText(
                text: 'العطل',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 27.w,
              ),
              MainText(
                text: 'توقف الماكينة وصوت يخرج منها',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            width: 7.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Row(
                  children: [
                    MainText(
                      text: 'التاريخ',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                    MainText(
                      text: '21-1-2023',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w100,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Expanded(
                child: Row(
                  children: [
                    MainText(
                      text: 'وقت',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    MainText(
                      text: '12.30 am',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w100,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 6.w,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              MainText(
                text: 'عنوان',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 27.w,
              ),
              // MainText(
              //   text: 'جدة-الحي الخامس-قطعة 200',
              //   font: 15.sp,
              //   color: Colors.black,
              //   weight: FontWeight.w500,
              // ),
            ],
          ),
          SizedBox(
            width: 14.w,
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
                        MagicRouter.navigateTo(TicketViewScreen());
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
