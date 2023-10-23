import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/provider/provider_auth.dart';
import 'package:golden_racks_admin/feature/widgets/drop_menu.dart';
import '../../../constants.dart';
import '../../../core/localization/demo_localization.dart';
import '../../../core/validate/validation.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';

class OrganizerLogin extends StatefulWidget {
  const OrganizerLogin({Key? key}) : super(key: key);

  @override
  State<OrganizerLogin> createState() => _OrganizerLoginState();
}

class _OrganizerLoginState extends State<OrganizerLogin> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool isLoginAdmin = true;

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final auth = AuthProvider.get(context);

    List<String> type = ['مدير التطبيق', 'فني'];

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background')),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                getAsset('logo'),
                              ),
                            ],
                          ),
                          SizedBox(height: 80.h),
                          DropMenu(
                            hint: 'اختر',
                            items: type,
                            onChanged: (v) {
                              isLoginAdmin = v == 'مدير التطبيق';
                              print(isLoginAdmin);
                            },
                            valid: (v) {
                              if (v == null) {
                                return 'اختر الدور';
                              } else
                                return null;
                            },
                          ),
                          CustomTextField(
                            controller: auth.loginUserNameController,
                            hasHeader: true,
                            header: 'اسم المستخدم',
                            hasHint: false,
                            headerFont: 12.sp,
                            headerTextColor: Colors.white,
                            headerWeight: FontWeight.w400,
                            headerFamily: 'Lato_regular',
                            type: TextInputType.text,
                            valid: (String? v) {
                              if (v!.isEmpty) {
                                return 'من فضلك ادخل اسم المستخدم';
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            controller: auth.loginPasswordController,
                            hasHint: false,
                            hasHeader: true,
                            header: 'كلمة المرور',
                            headerFont: 12.sp,
                            headerTextColor: Colors.white,
                            headerWeight: FontWeight.w400,
                            headerFamily: 'Lato_regular',
                            type: TextInputType.visiblePassword,
                            isPassword: true,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomButton(
                title: 'تسجيل الدخول',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  if (_form.currentState!.validate()) {
                    await auth.getAllCountries();

                    if (isLoginAdmin) {
                      log('Admin');
                      await auth.authLogin(
                        UserName: auth.loginUserNameController.text,
                        Password: auth.loginPasswordController.text,
                        UserRole: 2,
                      );
                    } else {
                      log('Technical');
                      await auth.authLogin(
                        UserName: auth.loginUserNameController.text,
                        Password: auth.loginPasswordController.text,
                        UserRole: 1,
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
