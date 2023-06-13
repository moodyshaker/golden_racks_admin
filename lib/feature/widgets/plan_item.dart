import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'customButton.dart';
import 'main_text.dart';

class PlanItem extends StatefulWidget {
  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300.h,
          margin: EdgeInsets.only(top: 8.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: gray_40)),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  color: gray_80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainText(
                      text: 'سنوي',
                      font: 16.sp,
                      color: kAccentColor,
                      weight: FontWeight.bold,
                    ),
                    MainText(
                      text: '4500 ر.س',
                      font: 16.sp,
                      color: kAccentColor,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              )),
              Expanded(
                  flex: 3,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                      ),
                      color: kAccentColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: 'الخطة السنوية',
                              font: 16.sp,
                              color: kBlackColor,
                              weight: FontWeight.bold,
                            ),
                            Container(
                              width: 58.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MainText(
                                    text: 'ماكينات',
                                    font: 12.sp,
                                    color: kBlackColor,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: 'صيانة بحد اقصى',
                              font: 12.sp,
                              color: kBlackColor,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 17.h,
                                  width: 17.h,
                                  decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.add,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                MainText(
                                  text: '3',
                                  font: 12.sp,
                                  color: kBlackColor,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(width: 10.w),
                                Container(
                                  height: 17.h,
                                  width: 17.h,
                                  decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.remove,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: 'تشمل صيانة دورية',
                              font: 12.sp,
                              color: kBlackColor,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                                  child: MainText(
                                    text: '12',
                                    font: 12.sp,
                                    color: kBlackColor,
                                    textAlign: TextAlign.center,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: 'صيانة طوارئ 3',
                              font: 12.sp,
                              color: kBlackColor,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                                  child: MainText(
                                    text: '3',
                                    font: 12.sp,
                                    color: kBlackColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MainText(
                                text: 'شاملة تزيت',
                                font: 12.sp,
                                color: kBlackColor,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: MainText(
                                text: 'نعم',
                                font: 12.sp,
                                color: kBlackColor,
                                textAlign: TextAlign.center,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MainText(
                              text: 'شاملة قطعة غيار',
                              font: 12.sp,
                              color: kBlackColor,
                              weight: FontWeight.w500,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: MainText(
                                text: 'لا',
                                font: 12.sp,
                                color: kBlackColor,
                                textAlign: TextAlign.center,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                title: 'شراء الخطة',
                verticalPadding: 20.h,
                font: 12.sp,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                child: CustomButton(
              title: 'طباعة تفاصيل الخطة',
              borderColor: gray_40,
              textColor: kBlackColor,
              borderWidth: 1.0,
              color: gray_20,
              font: 12.sp,
              verticalPadding: 20.h,
            )),
          ],
        )
      ],
    );
  }
}
