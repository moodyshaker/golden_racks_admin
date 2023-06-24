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

class AddASparePartScreen extends StatefulWidget {
  const AddASparePartScreen({Key? key}) : super(key: key);

  @override
  State<AddASparePartScreen> createState() => _AddASparePartScreenState();
}

class _AddASparePartScreenState extends State<AddASparePartScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OrganizerCustomScaffold(
      backgroundColor: Colors.white,
      hasAppbar: false,
      isHome: true,
      hasNavBar: false,
      title1: 'اضافة قطعة غيار',
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
                        SizedBox(height: 32.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(getAsset('add_bg')),
                                  fit: BoxFit.fill,
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
                            SizedBox(width: 21.w,),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(getAsset('add_bg')),
                                  fit: BoxFit.fill,
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
                            SizedBox(width: 21.w,),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(getAsset('add_bg')),
                                  fit: BoxFit.fill,
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
                          ],
                        ),
                        SizedBox(height: 11.h,),
                        CustomTextField(
                          horizontalPadding: 20.w,
                          // controller: organizer.loginEmailController,
                          hasHeader: false,
                          hint: 'اسم قطعة الغيار',
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
                          hint: 'سعر القطعة',
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
                          hint: 'سعر التكلفة',
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
                          hint: 'مواصفات القطعة',
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
                          hint: 'الكمية في المخزن',
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
                          hint: 'بلد المنشا',
                          hasHint: true,
                          hintFont: 15.sp,
                          hintColor: gray_40,
                          hintWeight: FontWeight.w400,
                          type: TextInputType.text,
                          valid: (String? v) {

                          },
                        ),
                        SizedBox(height: 8.h,),
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
              onPressed: () async {},
            ),
            SizedBox(height: 16.h,),
          ],
        ),
      ),
    );
  }
}
