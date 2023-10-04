import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/notification_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/search_tickets_screen.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';
import '../../../../constants.dart';
import '../../widgets/customButton.dart';

class FlowOnly extends StatefulWidget {
  const FlowOnly({Key? key}) : super(key: key);

  @override
  State<FlowOnly> createState() => _FlowOnlyState();
}

class _FlowOnlyState extends State<FlowOnly> {
  @override
  void initState() {
    super.initState();
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
      child: TechnicianCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: true,
        title1: 'للدخول للصفحات فقط',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                title: 'الي التذاكر',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(SearchTicketsScreen());
                },
              ),
              CustomButton(
                title: 'الاشعارات',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(NotificationScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
