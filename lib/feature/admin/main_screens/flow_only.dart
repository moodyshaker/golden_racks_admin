import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/activate_plane_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/subscribers_emergency_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/subscribers_periodic_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/requests_screen/unsubscribers_periodic_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/plan_item.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/add_technician_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/share_company_data_screen.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/technician_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../widgets/customButton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/organizerCustomScaffold.dart';
import '../other_screens/add_company_with_plan_screen.dart';

class FlowOnly extends StatefulWidget {
  const FlowOnly({Key? key}) : super(key: key);

  @override
  State<FlowOnly> createState() => _FlowOnlyState();
}

class _FlowOnlyState extends State<FlowOnly> {
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
        title1: 'للدخول للصفحات فقط',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                title: 'الطلبات الدورية لغير المشتركين',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(UnSubscribersPeriodicRequestsScreen());
                },
              ),
              CustomButton(
                title: 'طلبات الطوارئ للمشتركين',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(SubscribersEmergencyRequestsScreen());
                },
              ),
              CustomButton(
                title: 'الطلبات الدورية للمشتركين',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(SubscribersPeriodicRequestsScreen());
                },
              ),
              CustomButton(
                title: 'في انتظار التفعيل',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(ActivatePlanScreen());
                },
              ),
              CustomButton(
                title: 'بيانات الشركات',
                color: kSecondaryColor,
                height: 50.h,
                font: 16.sp,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  MagicRouter.navigateTo(SharedCompanyDataScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
