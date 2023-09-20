import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/active_plan_screens/activate_plane_admin_screen.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class OrganizerMain extends StatefulWidget {
  const OrganizerMain({Key? key}) : super(key: key);

  @override
  State<OrganizerMain> createState() => _OrganizerMainState();
}

class _OrganizerMainState extends State<OrganizerMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            MainText(
              text: 'القائمة الرئيسية',
              font: 20.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                children: [
                  NewApplicantWidget(
                    title: 'حسابات في انتظار تفعيل الخطط لها',
                    number: 20,
                    onPress: () async {
                      MagicRouter.navigateTo(ActivatePlanAdminScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewApplicantWidget extends StatelessWidget {
  final String title;
  final int number;
  final Function() onPress;

  const NewApplicantWidget({
    required this.title,
    required this.number,
    required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: '${title}',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
                MainText(
                  text: '${number}',
                  font: 50.sp,
                  weight: FontWeight.w700,
                  color: mainColor,
                ),
                MainText(
                  text: 'طلب جديد',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          CustomButton(
            title: 'عرض',
            color: kSecondaryColor,
            radius: 8.r,
            height: 42.h,
            width: 95.w,
            font: 16.sp,
            family: 'Lato_bold',
            textColor: Colors.white,
            withBorder: false,
            onPressed: onPress,
          ),
        ],
      ),
    );
  }
}
