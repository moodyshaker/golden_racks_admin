import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_plan_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddCompanyWithPlanScreen extends StatefulWidget {
  const AddCompanyWithPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyWithPlanScreen> createState() => _AddCompanyWithPlanScreenState();
}

class _AddCompanyWithPlanScreenState extends State<AddCompanyWithPlanScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.listenFalse(context).getEventCategory();
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                        children: [
                          SizedBox(height: 32.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'اسم المستخدم',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'اسم الشركة',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'مجال عمل الشركة',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'المدير المسؤول',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'العنوان بالتفصيل',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'البريد الاليكتروني',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'رقم الجوال',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 11.h,),
                          CustomTextField(
                            horizontalPadding: 20.w,
                            // controller: organizer.loginEmailController,
                            hasHeader: false,
                            hint: 'كلمة المرور',
                            hasHint: true,
                            hintFont: 15.sp,
                            hintColor: gray_40,
                            hintWeight: FontWeight.w400,
                            type: TextInputType.text,
                            valid: (String? v) {

                            },
                          ),
                          SizedBox(height: 16.h,),
                          CustomButton(
                            title: 'اختيار خطة',
                            color: lightBlueColor,
                            height: 50.h,
                            font: 16.sp,
                            family: 'Lato_bold',
                            textColor: Colors.white,
                            withBorder: false,
                            onPressed: () async {
                              MagicRouter.navigateTo(AddPlanScreen());
                            },
                          ),
                          SizedBox(height: 18.h,),
                          CustomButton(
                            title: 'تسجيل الحساب',
                            color: kSecondaryColor,
                            height: 50.h,
                            font: 16.sp,
                            family: 'Lato_bold',
                            textColor: Colors.white,
                            withBorder: false,
                            onPressed: () async {},
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
