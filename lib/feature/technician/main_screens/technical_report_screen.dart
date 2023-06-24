import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/bloc/app_cubit.dart';
import 'package:golden_racks_admin/core/bloc/home_cubit.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/ticket_item.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/customTextFeild.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class TechnicalReportScreen extends StatefulWidget {
  const TechnicalReportScreen({Key? key}) : super(key: key);

  @override
  State<TechnicalReportScreen> createState() => _TechnicalReportScreenState();
}

class _TechnicalReportScreenState extends State<TechnicalReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final cubit = AppCubit.get(context);
    final home = HomeCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: TechnicianCustomScaffold(
          backgroundColor: Colors.transparent,
          hasAppbar: false,
          isHome: true,
          hasNavBar: false,
          title1: 'التقرير الفني',
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                MainText(
                  text: 'قم بكتابة ملاحظاتك',
                  color: Colors.black,
                  font: 16.sp,
                  weight: FontWeight.w400,
                ),
                CustomTextField(
                  horizontalPadding: 20.w,
                  // controller: organizer.loginEmailController,
                  minLines: 16,
                  hasHeader: false,
                  hasHint: false,
                  type: TextInputType.text,
                  valid: (String? v) {

                  },
                ),
                SizedBox(height: 16.h,),
                CustomButton(
                  title: 'حفظ التقرير',
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
          )
      ),
    );
  }
}
