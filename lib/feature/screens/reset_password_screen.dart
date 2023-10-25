import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/provider/provider_profile.dart';
import 'package:golden_racks_admin/core/validate/validation.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final profileProvider = ProfileProvider.get(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getAsset('background1')), fit: BoxFit.fill)),
      child: CustomScaffold(
        backgroundColor: Colors.transparent,
        title: 'تغيير كلمة المرور',
        isHome: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      getAsset('logo'),
                      width: double.infinity,
                      height: 160.h,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      child: CustomTextField(
                        controller: profileProvider.oldPasswordController,
                        hasHint: false,
                        hasHeader: true,
                        header: 'كلمة المرور القديمة',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        valid: (String? v) => v!.isEmpty
                            ? demo.getTranslatedValue('password_validation')
                            : v.length < 8
                                ? demo.getTranslatedValue(
                                    'password_8ch_validation')
                                : Validations.passwordVerified(v)
                                    ? null
                                    : demo
                                        .getTranslatedValue('strong_password'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      child: CustomTextField(
                        controller: profileProvider.newPasswordController,
                        hasHint: false,
                        hasHeader: true,
                        header: 'كلمة المرور الجديدة',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        valid: (String? v) => v!.isEmpty
                            ? demo.getTranslatedValue('password_validation')
                            : v.length < 8
                                ? demo.getTranslatedValue(
                                    'password_8ch_validation')
                                : Validations.passwordVerified(v)
                                    ? null
                                    : demo
                                        .getTranslatedValue('strong_password'),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      child: CustomTextField(
                        controller:
                            profileProvider.confirmNewPasswordController,
                        hasHint: false,
                        hasHeader: true,
                        header: 'تأكيد كلمة المرور الجديدة',
                        headerFont: 12.sp,
                        headerTextColor: Colors.black,
                        headerWeight: FontWeight.w400,
                        type: TextInputType.visiblePassword,
                        isPassword: true,
                        valid: (String? v) => v!.isEmpty
                            ? demo.getTranslatedValue('password_validation')
                            : v.length < 8
                                ? demo.getTranslatedValue(
                                    'password_8ch_validation')
                                : Validations.passwordVerified(v)
                                    ? profileProvider
                                                .newPasswordController.text ==
                                            profileProvider
                                                .confirmNewPasswordController
                                                .text
                                        ? null
                                        : 'كلمة المرور غير متطابقة'
                                    : demo
                                        .getTranslatedValue('strong_password'),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      title: 'تغيير كلمة المرور',
                      color: kSecondaryColor,
                      withBorder: false,
                      height: 50.h,
                      font: 16.sp,
                      weight: FontWeight.w800,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          await profileProvider.resetPassword(
                            userId: Preferences.instance.getUserId,
                            oldPassword:
                                profileProvider.oldPasswordController.text,
                            newPassword:
                                profileProvider.newPasswordController.text,
                            confirmNewPassword: profileProvider
                                .confirmNewPasswordController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
