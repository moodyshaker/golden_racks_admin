import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/provider/provider_ready_plan.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/drop_menu.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import '../../../../constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';
import 'add_spare_part_screen.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<String> isSparePartsType = ['نعم', 'لا'];
    final readyPlanProvider = ReadyPlanProvider.get(context);
    return OrganizerCustomScaffold(
      backgroundColor: Colors.white,
      hasAppbar: false,
      isHome: true,
      hasNavBar: false,
      title1: 'انشاء خطة صيانة',
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 11.h,
                      ),
                      MainText(
                        text: 'مدة الخطة',
                        font: 12.sp,
                        color: Colors.black,
                        weight: FontWeight.w400,
                      ),
                      DropMenu(
                        hint: 'اختر مدة الخطة',
                        items: arabicPlanTypes.sublist(1),
                        // hintSize: 15.sp,
                        onChanged: (v) {
                          readyPlanProvider.PlanDurationController =
                              arabicPlanTypes.indexOf(v!);

                          log('plan duration > ${readyPlanProvider.PlanDurationController.toString()}');
                        },
                        valid: (v) {
                          if (v == null) {
                            return 'من فضلك اختر مدة الخطة';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller:
                            readyPlanProvider.NumberOfFixedVisitsController,
                        hasHeader: true,
                        header: 'عدد الزيارات الثابتة',
                        hasHint: false,
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        headerFamily: 'Lato_regular',
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل عدد الزيارات الثابتة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller:
                            readyPlanProvider.NumberOEmregencyVisitsController,
                        hasHint: false,
                        hasHeader: true,
                        header: 'عدد زيارات الطوارئ',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        headerFamily: 'Lato_regular',
                        type: TextInputType.number,
                        isPassword: false,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل عدد زيارات الطوارئ';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      MainText(
                        text: 'تشمل قطعة غيار',
                        font: 12.sp,
                        color: Colors.black,
                        weight: FontWeight.w400,
                      ),
                      DropMenu(
                        hint: 'نعم / لا',
                        items: isSparePartsType,
                        // hintSize: 15.sp,
                        onChanged: (v) {
                          if (v == 'نعم') {
                            readyPlanProvider.IsSparePartsController = true;
                            log('yes');
                            log(readyPlanProvider.IsSparePartsController
                                .toString());
                          } else {
                            readyPlanProvider.IsSparePartsController = false;
                            log('no');
                            log(readyPlanProvider.IsSparePartsController
                                .toString());
                          }
                        },
                        valid: (v) {
                          if (v == null) {
                            return 'من فضلك اختر هل تشمل قطعة غيار';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        hasHint: false,
                        hasHeader: true,
                        header: 'ثمن الخطة',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        headerFamily: 'Lato_regular',
                        type: TextInputType.number,
                        isPassword: false,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل عدد ثمن الخطة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.NumberOfRacksController,
                        horizontalPadding: 20.w,
                        hasHint: false,
                        hasHeader: true,
                        header: 'عدد المكينات',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        headerFamily: 'Lato_regular',
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل عدد المكينات';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.RacksUnitPriceController,
                        horizontalPadding: 20.w,
                        hasHint: false,
                        hasHeader: true,
                        header: 'سعر المكينة الواحدة',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        headerFamily: 'Lato_regular',
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل سعر المكينة الواحدة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              title: 'انشاء',
              color: kSecondaryColor,
              height: 50.h,
              font: 16.sp,
              family: 'Lato_bold',
              textColor: Colors.white,
              withBorder: false,
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  MagicRouter.navigateTo(AddASparePartScreen());
                }
              },
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
