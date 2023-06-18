import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/plan_item.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_technician_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({Key? key}) : super(key: key);

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.listenFalse(context).getEventCategory();
  }

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
        title1: 'اضافة خطة صيانة للحساب',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: 'مدة الخطة',
                    font: 12.sp,
                    color: Colors.black,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(width: 50.w,),
                  MainText(
                    text: 'GR6545-23',
                    font: 16.sp,
                    color: Colors.black,
                    weight: FontWeight.w800,
                  ),
                ],
              ),
              SizedBox(height: 8.h,),
              CustomTextField(
                horizontalPadding: 20.w,
                // controller: organizer.loginEmailController,
                hasHeader: false,
                hint: 'سنوي خطط بعد الشراء',
                hasHint: true,
                hintFont: 15.sp,
                hintColor: Colors.black,
                hintWeight: FontWeight.w400,
                type: TextInputType.text,
                valid: (String? v) {

                },
              ),
              SizedBox(height: 16.h,),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemBuilder: (BuildContext context, int i) => PlanItem(),
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
