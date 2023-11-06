import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/provider/provider_ready_plan.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import '../../../../constants.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddASparePartScreen extends StatefulWidget {
  @override
  State<AddASparePartScreen> createState() => _AddASparePartScreenState();
}

class _AddASparePartScreenState extends State<AddASparePartScreen> {
  List<String?> images = List.generate(3, (i) => null);
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final readyPlanProvider = ReadyPlanProvider.get(context);

    return OrganizerCustomScaffold(
      backgroundColor: Colors.white,
      hasAppbar: false,
      isHome: true,
      hasNavBar: true,
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
                    children: [
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (i) => InkWell(
                            onTap: () async {
                              File? file = await readyPlanProvider
                                  .pickImageFromGallary();
                              if (file != null) {
                                images[i] = file.path;
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: images[i] == null
                                    ? DecorationImage(
                                        image: AssetImage(getAsset('add_bg')),
                                        fit: BoxFit.fill,
                                      )
                                    : DecorationImage(
                                        image: FileImage(
                                          File(images[i]!),
                                        ),
                                      ),
                              ),
                              padding: EdgeInsets.all(24.0),
                              height: 74.h,
                              width: 74.w,
                              child: Center(
                                child: Image.asset(
                                  getAsset('brown_add_icon'),
                                ),
                              ),
                            ),
                          ),
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
                          if (images[0] == null &&
                              images[1] == null &&
                              images[2] == null) {
                            return 'من فضلك ادخل صور قطعة الغيار';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.SparePartsNameController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'اسم قطعة الغيار',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.text,
                        valid: (String? v) {
                          if (v!.isEmpty) {
                            return 'ادخل اسم قطعة الغيار';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.SparePartsPriceController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'سعر القطعة',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل سعر القطعة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.TotalCostController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'سعر التكلفة',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل سعر التكلفة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller:
                            readyPlanProvider.SparePartsDescriptionController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'مواصفات القطعة',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.text,
                        valid: (String? v) {
                          if (v!.isEmpty) {
                            return 'ادخل مواصفات القطعة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.QuntityInStockController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'الكمية في المخزن',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل الكمية في المخزن';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider
                            .NumberOfFreeSparePartQuantityController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'عدد قطع الغيار المجانية',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.number,
                        valid: (String? v) {
                          final n = num.tryParse(v!);
                          if (v.isEmpty || n == null) {
                            return 'ادخل عدد قطع الغيار المجانية';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      CustomTextField(
                        controller: readyPlanProvider.MadeInController,
                        horizontalPadding: 20.w,
                        hasHeader: false,
                        hint: 'بلد المنشأ',
                        hasHint: true,
                        hintFont: 15.sp,
                        hintColor: gray_40,
                        hintWeight: FontWeight.w400,
                        type: TextInputType.text,
                        valid: (String? v) {
                          if (v!.isEmpty) {
                            return 'ادخل بلد المنشأ';
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
              title: 'اضافة',
              color: kSecondaryColor,
              height: 50.h,
              font: 16.sp,
              family: 'Lato_bold',
              textColor: Colors.white,
              withBorder: false,
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  List<File> files = [];
                  images.forEach((String? e) {
                    if (e != null) {
                      files.add(File(e));
                    }
                  });

                  await readyPlanProvider.addReadyPlan(
                    PlanDuration: readyPlanProvider.PlanDurationController!,
                    PlanName: readyPlanProvider.PlanNameController.text,
                    NumberOfFixedVisits: int.parse(
                      readyPlanProvider.NumberOfFixedVisitsController.text,
                    ),
                    NumberOEmregencyVisits: int.parse(
                      readyPlanProvider.NumberOEmregencyVisitsController.text,
                    ),
                    NumberOfRacks: int.parse(
                      readyPlanProvider.NumberOfRacksController.text,
                    ),
                    RacksUnitPrice: double.parse(
                      readyPlanProvider.RacksUnitPriceController.text,
                    ),
                    IsActive: readyPlanProvider.IsActiveController,
                    IsSpareParts: readyPlanProvider.IsSparePartsController,
                    /////////take all of them///////////////
                    SparePartsName:
                        readyPlanProvider.SparePartsNameController.text,
                    SparePartsPrice: double.parse(
                      readyPlanProvider.SparePartsPriceController.text,
                    ),
                    TotalCost: double.parse(
                      readyPlanProvider.TotalCostController.text,
                    ),
                    SparePartsDescription:
                        readyPlanProvider.SparePartsDescriptionController.text,
                    QuntityInStock: int.parse(
                      readyPlanProvider.QuntityInStockController.text,
                    ),
                    MadeIn: readyPlanProvider.MadeInController.text,
                    SparePartImages: files,
                    NumberOfFreeSparePartQuantity: int.parse(
                      readyPlanProvider
                          .NumberOfFreeSparePartQuantityController.text,
                    ),
                  );
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
