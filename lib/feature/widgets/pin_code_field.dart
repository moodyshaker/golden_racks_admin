import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../constants.dart';
import '../../core/bloc/language_cubit.dart';
import '../../core/localization/demo_localization.dart';

class PinCodeField extends StatelessWidget {
  final void Function(String?)? onSave;
  final void Function(String) onChanged;
  final TextEditingController? controller;

  PinCodeField({this.onSave, required this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final lang = LanguageCubit.get(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        validator: (String? v) => v!.isEmpty
            ? demo.getTranslatedValue('code_validation')
            : v.length < 4
                ? demo.getTranslatedValue('code_less_4_validation')
                : null,
        appContext: context,
        errorTextDirection: lang.locale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        controller: controller,
        autovalidateMode: AutovalidateMode.disabled,
        pastedTextStyle: TextStyle(color: Colors.black),
        length: 4,
        animationType: AnimationType.fade,
        cursorColor: kMainColor,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
        enabled: true,
        backgroundColor: Colors.transparent,
        autoDisposeControllers: false,
        autoDismissKeyboard: true,
        enablePinAutofill: true,
        textStyle: TextStyle(fontSize: 20, color: Colors.black),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldHeight: 70.h,
          fieldWidth: 70.w,
          borderRadius: BorderRadius.circular(10.r),
          activeFillColor: kBackgroundColor,
          activeColor: kBackgroundColor,
          inactiveColor: kBackgroundColor,
          inactiveFillColor: kBackgroundColor,
          selectedFillColor: kBackgroundColor,
          selectedColor: kBackgroundColor,
          disabledColor: kBackgroundColor,
        ),
        onSaved: onSave,
        errorTextSpace: 30,
      ),
    );
  }
}
