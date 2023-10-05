// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../core/bloc/language_cubit.dart';
import 'main_text.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final String? header;
  final String? headerFamily;
  final int? minLines;
  final int? maxLines;
  final bool? hasLabel;
  final bool? hasHint;
  final Color? hintColor;
  final int? maxLength;
  final bool nullMax;
  final bool hasHeader;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onsave;
  final Function()? suffixCallback;
  final Function(String?)? onChange;
  final Function()? iconCallback;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? headerTextColor;
  final Color? headerColor;
  final bool isPassword;
  final double? headerFont;
  final double? radius;
  final FontWeight? headerWeight;
  final FontWeight? hintWeight;
  final double? hintFont;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(String?)? onSubmit;
  final Widget? prefixIcon;
  final FocusNode? focus;
  final bool autoFocus;
  final bool? read;
  final bool withPasswordIcon;
  final bool isPhone;
  final bool? flag;
  final TextAlign? align;
  final TextInputAction? action;
  final VoidCallback? edit;
  final bool? isEdit;
  final double? hor;
  final Color? borderColor;
  final bool underlineBorder;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool? enable;

  CustomTextField({
    Key? key,
    this.hint,
    this.header,
    this.headerFamily,
    this.minLines,
    this.maxLines,
    this.hasLabel,
    this.hasHint,
    this.hintColor,
    this.maxLength,
    this.nullMax = false,
    this.hasHeader = false,
    this.type,
    this.inputFormatters,
    this.onsave,
    this.suffixCallback,
    this.onChange,
    this.iconCallback,
    this.valid,
    this.validationMode,
    this.suffixIcon,
    this.fillColor,
    this.headerTextColor,
    this.headerColor,
    this.isPassword = false,
    this.headerFont,
    this.radius,
    this.headerWeight,
    this.hintWeight,
    this.hintFont,
    this.controller,
    this.onTap,
    this.onSubmit,
    this.prefixIcon,
    this.focus,
    this.autoFocus = false,
    this.read,
    this.withPasswordIcon = true,
    this.isPhone = false,
    this.flag,
    this.align,
    this.action,
    this.edit,
    this.isEdit,
    this.hor,
    this.borderColor,
    this.underlineBorder = true,
    this.horizontalPadding,
    this.verticalPadding,
    this.enable,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = LanguageCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.hasHeader
            ? MainText(
                text: widget.header ?? widget.hint,
                font: widget.headerFont ?? 18.sp,
                color: widget.headerTextColor ?? Color(0xff7c7c7c),
                weight: widget.headerWeight ?? FontWeight.bold,
                family: widget.headerFamily ?? 'Lato_regular',
                // family: 'Cairo',
              )
            : Container(),
        TextFormField(
          enabled: widget.enable,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmit,
          validator: widget.valid,
          controller: widget.controller,
          cursorColor: Colors.grey,
          onSaved: widget.onsave,
          focusNode: widget.focus,
          inputFormatters: widget.inputFormatters,
          textAlign: widget.align ?? TextAlign.start,
          textInputAction: widget.action,
          readOnly: widget.read == true ? true : false,
          maxLines:
              widget.nullMax ? null : widget.maxLines ?? widget.minLines ?? 1,
          minLines: widget.minLines,
          autofocus: widget.autoFocus,
          maxLength: widget.isPhone ? 10 : widget.maxLength,
          obscureText: widget.isPassword ? _isHidden : false,
          keyboardType: widget.type,
          onChanged: widget.onChange,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
            fontFamily: 'Cairo',
          ),
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            hintText: widget.hasHint == true ? widget.hint : null,
            fillColor: widget.fillColor ?? kAccentColor,
            filled: true,
            errorMaxLines: 2,
            contentPadding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding ?? 10.w,
                vertical: widget.verticalPadding ?? 8.h),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: IconButton(
                      icon: widget.prefixIcon!,
                      onPressed: () {},
                    ),
                  )
                : null,
            labelText: widget.hasLabel == true ? widget.hint : null,
            prefix: widget.flag == true ? const MainText(text: "+966  ") : null,
            icon: widget.isEdit == true ? const Icon(Icons.edit) : null,
            counterText: '',
            labelStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamily: widget.headerFamily ?? 'Lato_regular',
            ),
            hintStyle: TextStyle(
              fontSize: widget.hintFont ?? 14.sp,
              fontWeight: widget.hintWeight ?? FontWeight.w800,
              color: widget.hintColor ?? Color(0xff7c7c7c),
              fontFamily: 'Cairo',
            ),
            suffixIcon: widget.isPassword
                ? widget.withPasswordIcon
                    ? Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: IconButton(
                          onPressed: _visibility,
                          alignment: Alignment.center,
                          icon: _isHidden
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                        ),
                      )
                    : IconButton(
                        onPressed: () {},
                        icon: Container(),
                      )
                : Padding(
                    padding: EdgeInsets.only(
                        left: lang.locale.languageCode == 'en' ? 8.w : 0.w,
                        right: lang.locale.languageCode == 'en' ? 0.w : 8.w),
                    child: GestureDetector(
                      onTap: widget.suffixCallback,
                      child: widget.suffixIcon ??
                          Container(
                            height: 25.h,
                            width: 25.w,
                          ),
                    ),
                  ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? gray_40, width: 1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? gray_40, width: 1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? gray_40, width: 1),
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
        ),
      ],
    );
  }
}
