import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_plan_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/drop_menu.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

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
    List<String> planTypes = [
      'سنوي' , 'شهري' , 'اسبوعي' , 'يومي'
    ];
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
                        SizedBox(height: 11.h,),
                        MainText(
                          text: 'مدة الخطة',
                          font: 12.sp,
                          color: Colors.black,
                          weight: FontWeight.w400,
                        ),
                        DropMenu(
                          hint: 'سنوي',
                          items: planTypes,
                          hintSize: 15.sp,
                          onChanged: (v){

                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          hasHeader: true,
                          header: 'عدد الزيارات الثابتة',
                          hasHint: false,
                          headerFont: 12.sp,
                          headerTextColor: Colors.black,
                          headerWeight: FontWeight.w400,
                          headerFamily: 'Lato_regular',
                          type: TextInputType.text,
                          valid: (String? v) {

                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          hasHint: false,
                          hasHeader: true,
                          header: 'عدد زيارات الطوارئ',
                          headerFont: 12.sp,
                          headerTextColor: Colors.black,
                          headerWeight: FontWeight.w400,
                          headerFamily: 'Lato_regular',
                          type: TextInputType.text,
                          isPassword: false,
                          valid: (String? v){}
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextField(
                          hasHeader: true,
                          header: 'تشمل قطع غيار',
                          hasHint: false,
                          headerFont: 12.sp,
                          headerTextColor: Colors.black,
                          headerWeight: FontWeight.w400,
                          headerFamily: 'Lato_regular',
                          type: TextInputType.text,
                          valid: (String? v) {

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
                            type: TextInputType.text,
                            isPassword: false,
                            valid: (String? v){}
                        ),
                        SizedBox(height: 8.h,),
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
              onPressed: () async {},
            ),
            SizedBox(height: 16.h,),
          ],
        ),
      ),
    );
  }
}
