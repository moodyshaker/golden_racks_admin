import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/subscribers_request_item.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class SubscribersPeriodicRequestsAdminScreen extends StatefulWidget {
  const SubscribersPeriodicRequestsAdminScreen({Key? key}) : super(key: key);

  @override
  State<SubscribersPeriodicRequestsAdminScreen> createState() =>
      _SubscribersPeriodicRequestsAdminScreenState();
}

class _SubscribersPeriodicRequestsAdminScreenState
    extends State<SubscribersPeriodicRequestsAdminScreen> {
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
        title1: 'تحديد فني لطلبات الدورية لغير المشتركين',
        body: Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) =>
                SubscribersRequestsItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
