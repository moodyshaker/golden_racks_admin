import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/models/ready_plan_model.dart';

import '../../../../constants.dart';
import '../../../../core/provider/provider_ready_plan.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class PlanItem extends StatefulWidget {
  final ReadyPlanModel readyPlan;

  const PlanItem({required this.readyPlan});

  @override
  State<PlanItem> createState() => _PlanItemState();
}

class _PlanItemState extends State<PlanItem> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Preferences _preferences = Preferences.instance;
  DateTime? chosenTime;
  @override
  Widget build(BuildContext context) {
    final readyPlanProvider = ReadyPlanProvider.get(context);
    return Form(
      key: _form,
      child: Column(
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
                          text: arabicPlanTypes[englishPlanTypes.indexOf(
                            widget.readyPlan.planDuration!,
                          )],
                          font: 16.sp,
                          color: kAccentColor,
                          weight: FontWeight.bold,
                        ),
                        MainText(
                          textAlign: TextAlign.center,
                          text: '${widget.readyPlan.planPrice} ر.س',
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
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.add,
                                      size: 10,
                                      color: kAccentColor,
                                    ),
                                    onTap: () {
                                      readyPlanProvider.increaseRack(
                                          readyPlan: widget.readyPlan);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                MainText(
                                  text: '${widget.readyPlan.numberOfRacks}',
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
                                        readyPlanProvider.increaseRack(
                                            readyPlan: widget.readyPlan);
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
                                        '${widget.readyPlan.numberOfFixedVisits}',
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  child: MainText(
                                    text:
                                        '${widget.readyPlan.numberOEmregencyVisits}',
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
                                text: widget.readyPlan.isSpareParts!
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
          Align(
            alignment: Alignment.topRight,
            child: Column(
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
                InkWell(
                  onTap: () async {
                    chosenTime = await showDatePicker(
                      context: context,
                      initialDate: chosenTime ??= DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      builder: ((context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.brown,
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.brown,
                            ),
                          ),
                          child: child!,
                        );
                      }),
                    );
                  },
                  child: Container(
                    height: 33.h,
                    width: 42.w,
                    child: Image.asset(
                      getAsset('calendar_with_point'),
                      color: gray_60,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FormField(
            builder: (FormFieldState<String> state) {
              return MainText(
                text: state.errorText ?? '',
                color: Colors.red,
                font: 16.sp,
                horizontalPadding: 16.w,
                // verticalPadding: 8.h,
              );
            },
            validator: (v) {
              if (chosenTime == null) {
                return 'من فضلك ادخل تاريخ بداية الخطة';
              } else {
                return null;
              }
            },
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
              if (_form.currentState!.validate()) {
                log('id > ' + widget.readyPlan.id.toString());
                log('num of racks > ' +
                    widget.readyPlan.numberOfRacks.toString());
                log('plan price > ' + widget.readyPlan.planPrice.toString());
                log('chosen time > ' + chosenTime.toString());
                await readyPlanProvider.subscribeToReadyPlan(
                  UserId: _preferences.getRegisterdUserId,
                  ReadyPlanId: widget.readyPlan.id!,
                  IsFree: true,
                  NumberOfRacks: widget.readyPlan.numberOfRacks!,
                  StartDate: chosenTime.toString(),
                  NumberOfFixedVisits: widget.readyPlan.numberOfFixedVisits!,
                  NumberOEmregencyVisits:
                      widget.readyPlan.numberOEmregencyVisits!,
                  PaymentMethod: 0,
                  TransactionId: 1,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
