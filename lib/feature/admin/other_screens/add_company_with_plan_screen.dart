import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/provider/provider_auth.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_plan_screen.dart';
import '../../../../constants.dart';
import '../../../core/localization/demo_localization.dart';
import '../../../core/models/country_model.dart' as c;
import '../../../core/provider/provider_ready_plan.dart';
import '../../../core/validate/validation.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/drop_menu.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddCompanyWithPlanScreen extends StatefulWidget {
  const AddCompanyWithPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyWithPlanScreen> createState() =>
      _AddCompanyWithPlanScreenState();
}

class _AddCompanyWithPlanScreenState extends State<AddCompanyWithPlanScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  c.Country? selectedCountry;
  c.City? selectedCity;
  c.State? selectedState;

  String? selectedCountryValue;
  String? selectedCityValue;
  String? selectedStateValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.get(context);
    final demo = DemoLocalization.of(context);
    final readyPlanProvider = ReadyPlanProvider.get(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
        title1: 'انشاء حسابات للشركات وربطها بخطة',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomTextField(
                          controller: auth.registerUserNameController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'اسم المستخدم',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم المستخدم';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registerCompanyNameController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'اسم الشركة',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم الشركة';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registerCompanybusinessController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'مجال عمل الشركة',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل مجال عمل الشركة';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registerfullNameController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'المدير المسؤول',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم المدير المسؤول';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),

                        /////COUNTRY///////
                        DropMenu(
                          hintColor: gray_60,
                          hint: 'اختر الدولة',
                          items: auth.countries
                              .where((e) => e.cities!.isNotEmpty)
                              .map((e) => e.countryName!)
                              .toList(),
                          value: selectedCountryValue,
                          onChanged: (v) {
                            setState(
                              () {
                                selectedCityValue = null;
                                selectedStateValue = null;
                                selectedCountry = auth.countries
                                    .where((e) => (v == e.countryName!))
                                    .toList()[0];
                                selectedCountryValue = v!;
                                log('Country > ${selectedCountry!.id}');
                                log('Country > ${selectedCountryValue}');
                              },
                            );
                          },
                          valid: (v) {
                            if (v == null) {
                              return 'من فضلك اختر الدولة';
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        /////CITY///////
                        DropMenu(
                          hintColor: gray_60,
                          hint: 'اختر المدينة',
                          items: selectedCountry != null
                              ? selectedCountry!.cities!
                                  .map((e) => e.cityName!)
                                  .toList()
                              : [],
                          value: selectedCityValue,
                          onChanged: (v) {
                            selectedStateValue = null;
                            setState(() {
                              selectedCity = selectedCountry!.cities!
                                  .where((e) => (v == e.cityName!))
                                  .toList()[0];
                              selectedCityValue = v!;
                              log('City > ${selectedCity!.id}');
                              log('City > ${selectedCityValue}');
                            });
                          },
                          valid: (v) {
                            if (v == null) {
                              return 'من فضلك اختر المدينة';
                            } else
                              return null;
                          },
                        ),

                        /////STATE///////
                        DropMenu(
                          hintColor: gray_60,
                          hint: 'اختر المنطقة',
                          items: selectedCity != null
                              ? selectedCity!.states!
                                  .map((e) => e.stateName!)
                                  .toList()
                              : [],
                          value: selectedStateValue,
                          onChanged: (v) {
                            setState(() {
                              selectedState = selectedCity!.states!
                                  .where((e) => (v == e.stateName!))
                                  .toList()[0];
                              selectedStateValue = v!;
                              log('State > ${selectedState!.id}');
                              log('State > ${selectedStateValue}');
                            });
                          },
                          valid: (v) {
                            if (v == null) {
                              return 'من فضلك اختر المنطقة';
                            } else
                              return null;
                          },
                        ),

                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registerEmailController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'البريد الاليكتروني',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل البريد الاليكتروني';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registermobileNumberController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'رقم الجوال',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (v) {
                            final n = num.tryParse(v!);
                            if (v.isEmpty || n == null) {
                              return 'من فضلك ادخل رقم الجوال';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        CustomTextField(
                          controller: auth.registerPasswordController,
                          horizontalPadding: 20.w,
                          hasHeader: false,
                          hint: 'كلمة المرور',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_60,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) => v!.isEmpty
                              ? 'من فضلك ادخل كلمة المرور'
                              : v.length < 8
                                  ? demo.getTranslatedValue(
                                      'password_8ch_validation',
                                    )
                                  : Validations.passwordVerified(v)
                                      ? null
                                      : demo.getTranslatedValue(
                                          'strong_password',
                                        ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomButton(
                          title: 'اختيار خطة',
                          color: lightBlueColor,
                          height: 50.h,
                          font: 16.sp,
                          family: 'Lato_bold',
                          textColor: Colors.white,
                          withBorder: false,
                          onPressed: () async {
                            await readyPlanProvider.getReadyPlan(
                              planDuration:
                                  readyPlanProvider.chosenPlanDuration,
                            );
                            MagicRouter.navigateTo(AddPlanScreen());
                          },
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        CustomButton(
                          title: 'تسجيل الحساب',
                          color: kSecondaryColor,
                          height: 50.h,
                          font: 16.sp,
                          family: 'Lato_bold',
                          textColor: Colors.white,
                          withBorder: false,
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              await readyPlanProvider.getReadyPlan(
                                planDuration:
                                    readyPlanProvider.chosenPlanDuration,
                              );
                              await auth.authRegister(
                                countryId: selectedCountry!.id!,
                                cityId: selectedCity!.id!,
                                stateId: selectedState!.id!,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
