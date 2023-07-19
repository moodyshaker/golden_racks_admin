import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/subscribers_request_item.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../admin/main_screens/widgets/maintenance_for_subscribers_item.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class MaintenanceForSubscribers extends StatefulWidget {
  const MaintenanceForSubscribers({Key? key}) : super(key: key);

  @override
  State<MaintenanceForSubscribers> createState() => _MaintenanceForSubscribersState();
}

class _MaintenanceForSubscribersState extends State<MaintenanceForSubscribers> {

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
        hasAppbar:false,
        isHome: true,
        hasNavBar: false,
        title1: 'تحديد فني لطلبات الصيانة الدورية للمشتركين',
        body: ListView.builder(
          padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemBuilder: (BuildContext context, int i) => MaintenanceForSubscribersItem(),
          itemCount: 2,
        ),
      ),
    );
  }
}
