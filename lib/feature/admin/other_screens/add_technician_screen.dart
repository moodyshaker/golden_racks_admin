import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/provider/provider_add_technation.dart';
import 'package:golden_racks_admin/core/validate/validation.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddTechnicianScreen extends StatefulWidget {
  const AddTechnicianScreen({Key? key}) : super(key: key);

  @override
  State<AddTechnicianScreen> createState() => _AddTechnicianScreenState();
}

class _AddTechnicianScreenState extends State<AddTechnicianScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.listenFalse(context).getEventCategory();
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final addTechnationProvider = AddTechnationProvider.get(context);

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
        title1: 'انشاء حسابات الدخول للفنين',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await addTechnationProvider.pickImageFromGallary();

                            if (addTechnationProvider.selectedTechnicalImage !=
                                null) {
                              log(addTechnationProvider
                                  .selectedTechnicalImage!.path);
                            }
                          },
                          child: Container(
                            height: 97.h,
                            width: 97.w,
                            child:
                                addTechnationProvider.selectedTechnicalImage ==
                                        null
                                    ? Image.asset(getAsset('defualt_pic'))
                                    : Image.file(
                                        addTechnationProvider
                                            .selectedTechnicalImage!,
                                      ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          controller:
                              addTechnationProvider.addTechUserNameController,
                          hasHeader: false,
                          hint: 'اسم المستخدم',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم المستخدم';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          controller:
                              addTechnationProvider.addTechfullNameController,
                          hasHeader: false,
                          hint: 'اسم الفني كاملا',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل اسم الفني كاملا';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          controller:
                              addTechnationProvider.addTechEmailController,
                          hasHeader: false,
                          hint: 'البريد الاليكتروني',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل البريد الالكتروني';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          controller: addTechnationProvider
                              .addTechmobileNumberController,
                          hasHeader: false,
                          hint: 'رقم الجوال',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) {
                            if (v!.isEmpty) {
                              return 'من فضلك ادخل رقم الجوال';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          controller:
                              addTechnationProvider.addTechPasswordController,
                          hasHeader: false,
                          hint: 'كلمة المرور',
                          isPassword: true,
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
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
                          height: 22.h,
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
                              await addTechnationProvider.addNewTechnical(
                                fullName: addTechnationProvider
                                    .addTechfullNameController.text,
                                Password: addTechnationProvider
                                    .addTechPasswordController.text,
                                UploadImage: addTechnationProvider
                                    .selectedTechnicalImage!,
                                mobileNumber: addTechnationProvider
                                    .addTechmobileNumberController.text,
                                Email: addTechnationProvider
                                    .addTechEmailController.text,
                                UserName: addTechnationProvider
                                    .addTechUserNameController.text,
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
