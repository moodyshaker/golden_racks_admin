import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../../core/localization/demo_localization.dart';
import '../../../widgets/main_text.dart';

class TicketItem extends StatelessWidget {
  // const TicketItem(Key? key)
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getAsset('plan_background')),
              fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainText(
                text: demo.getTranslatedValue('amazon_company'),
                font: 15.sp,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
              MainText(
                text: demo.getTranslatedValue('ticket_number'),
                font: 15.sp,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 13.h,
          ),
          MainText(
            text: demo.getTranslatedValue('break_in_the_rack'),
            font: 16.sp,
            weight: FontWeight.w700,
            color: Colors.black,
          ),
          SizedBox(
            height: 13.h,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        MainText(
                          text: demo.getTranslatedValue('the_technician'),
                          font: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        MainText(
                          text: demo.getTranslatedValue('name_str'),
                          font: 15.sp,
                          weight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MainText(
                          text: demo.getTranslatedValue('the_date'),
                          font: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
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
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.brown,
                  ),
                  child: Center(
                    child: MainText(
                      text: demo.getTranslatedValue('visit_details'),
                      color: Colors.white,
                      font: 15.sp,
                      weight: FontWeight.w700,
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
