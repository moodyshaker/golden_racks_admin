import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class NeedActivateItemTech extends StatelessWidget {
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
          SizedBox(
            width: 9.w,
          ),
          Row(
            children: [
              Container(
                height: 38.h,
                width: 38.w,
                child: Image.asset(
                  getAsset('defualt_pic'),
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: 'شركة محمد جاد',
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
                text: 'الخطة المختارة',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 13.w,
              ),
              MainText(
                text: 'الاساسية 2400 ريال',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
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
                text: 'طريقة الدفع',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 31.w,
              ),
              MainText(
                text: 'تحويل رقم 246545',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
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
                width: 61.w,
              ),
              MainText(
                text: 'جدة-الحي الخامس-قطعة 200',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
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
                      title: 'تفعيل الخطة',
                      color: kSecondaryColor,
                      height: 50.h,
                      font: 12.sp,
                      family: 'Lato_bold',
                      textColor: Colors.white,
                      weight: FontWeight.w800,
                      withBorder: false,
                      onPressed: () async {},
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    CustomButton(
                      horizontalPadding: 19.w,
                      title: 'رفض الطلب',
                      color: Colors.red,
                      height: 50.h,
                      font: 16.sp,
                      family: 'Lato_bold',
                      withBorder: false,
                      borderWidth: 1.0,
                      borderColor: Colors.white,
                      onPressed: () async {},
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
