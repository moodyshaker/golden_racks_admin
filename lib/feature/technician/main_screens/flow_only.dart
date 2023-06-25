import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/activate_plane_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/subscribers_emergency_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/subscribers_periodic_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/unsubscribers_periodic_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_spare_part_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/create_plan_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/share_company_data_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/show_plans_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/ticket_view_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/notification_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/show_spar_parts_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/tickets_screen.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/organizerCustomScaffold.dart';

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
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
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
                  MagicRouter.navigateTo(TicketsScreen());
                },
              ),
              CustomButton(
                title: 'عرض قطع الغيار',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(ShowSparPartsScreen());
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
              CustomButton(
                title: 'عرض التذكرة',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(TicketViewScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
