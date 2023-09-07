import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/subscribers_request_item.dart';

class SubscribersEmergencyRequestsAdminScreen extends StatefulWidget {
  const SubscribersEmergencyRequestsAdminScreen({Key? key}) : super(key: key);

  @override
  State<SubscribersEmergencyRequestsAdminScreen> createState() =>
      _SubscribersEmergencyRequestsAdminScreenState();
}

class _SubscribersEmergencyRequestsAdminScreenState
    extends State<SubscribersEmergencyRequestsAdminScreen> {
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
        title1: 'تحديد فني لطلبات الطوارئ للمشتركين',
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
