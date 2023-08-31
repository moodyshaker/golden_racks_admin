import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';

import '../../../../constants.dart';
import '../../../../core/provider/provider_ready_plan.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class PlanItem extends StatefulWidget {
  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  Preferences _preferences = Preferences.instance;
  @override
  Widget build(BuildContext context) {
    final readyPlanProvider = ReadyPlanProvider.get(context);
    return Column(
      children: [
        Container(
          height: 300.h,
          margin: EdgeInsets.only(top: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: gray_40),
          ),
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
                        textAlign: TextAlign.center,
                        text: readyPlanProvider.arabicPlanTypes[
                            readyPlanProvider.englishPlanTypes.indexOf(
                          readyPlanProvider.chosenReadyPlan.planDuration!,
                        )],
                        font: 16.sp,
                        color: kAccentColor,
                        weight: FontWeight.bold,
                      ),
                      MainText(
                        textAlign: TextAlign.center,
                        text:
                            '${readyPlanProvider.chosenReadyPlan.planPrice} ر.س',
                        font: 16.sp,
                        color: kAccentColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 20.h,
                  ),
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
                            text:
                                'الخطة السنوية + ${readyPlanProvider.chosenReadyPlan.id}',
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
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  child: Icon(
                                    Icons.add,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                  onTap: () {
                                    readyPlanProvider.increaseRack();
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              MainText(
                                text:
                                    '${readyPlanProvider.chosenReadyPlan.numberOfRacks}',
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
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  child: Icon(
                                    Icons.remove,
                                    size: 10,
                                    color: kAccentColor,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      readyPlanProvider.increaseRack();
                                    });
                                  },
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.w,
                                ),
                                child: MainText(
                                  text:
                                      '${readyPlanProvider.chosenReadyPlan.numberOfFixedVisits}',
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
                            text: 'صيانة طوارئ',
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
                                  text:
                                      '${readyPlanProvider.chosenReadyPlan.numberOEmregencyVisits}',
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
                              text: readyPlanProvider
                                      .chosenReadyPlan.isSpareParts!
                                  ? 'نعم'
                                  : 'لا',
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
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                MainText(
                  text: 'اختر تاريخ بداية الخطة',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                    height: 33.h,
                    width: 42.w,
                    child: Image.asset(getAsset('calendar_icon'))),
              ],
            ),
            Column(
              children: [
                MainText(
                  text: 'اختر تاريخ النهاية',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  height: 33.h,
                  width: 42.w,
                  child: Image.asset(
                    getAsset('calendar_icon'),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        CustomButton(
          title: 'اضافة للحساب',
          verticalPadding: 20.h,
          font: 12.sp,
          borderColor: Colors.transparent,
          onPressed: () async {
            log('id > ' + readyPlanProvider.chosenReadyPlan.id.toString());
            log('num of racks > ' +
                readyPlanProvider.chosenReadyPlan.numberOfRacks.toString());
            log('plan price > ' +
                readyPlanProvider.chosenReadyPlan.planPrice.toString());
            await readyPlanProvider.subscribeToReadyPlan(
              UserId: _preferences.getRegisterdUserId,
              ReadyPlanId: readyPlanProvider.chosenReadyPlan.id!,
              IsFree: false,
              NumberOfRacks: readyPlanProvider.chosenReadyPlan.numberOfRacks!,
              StartDate: DateTime.now().toString(),
              NumberOfFixedVisits:
                  readyPlanProvider.chosenReadyPlan.numberOfFixedVisits!,
              NumberOEmregencyVisits:
                  readyPlanProvider.chosenReadyPlan.numberOEmregencyVisits!,
              PaymentMethod: 0,
              TransactionId: 1,
            );
          },
        ),
      ],
    );
  }
}
