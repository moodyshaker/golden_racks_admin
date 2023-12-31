import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/bloc/language_cubit.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/show_ticket_screen.dart';
import '../../../widgets/main_text.dart';

class TicketItem extends StatelessWidget {

  // const TicketItem(Key? key)
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final lang = LanguageCubit.get(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w , horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
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
          // SizedBox(height: 13.h,),
          // MainText(
          //   text: demo.getTranslatedValue('break_in_the_rack'),
          //   font: 16.sp,
          //   weight: FontWeight.w700,
          //   color: Colors.black,
          // ),
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
                    MagicRouter.navigateTo(ShowTicketScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: MainText(
                        text: 'فتح التذكرة',
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
    );
  }
}
