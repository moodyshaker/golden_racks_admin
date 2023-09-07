import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/requests_item.dart';

class UnSubscribersPeriodicRequestsAdminScreen extends StatefulWidget {
  const UnSubscribersPeriodicRequestsAdminScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersPeriodicRequestsAdminScreen> createState() =>
      _UnSubscribersPeriodicRequestsAdminScreenState();
}

class _UnSubscribersPeriodicRequestsAdminScreenState
    extends State<UnSubscribersPeriodicRequestsAdminScreen> {
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
            itemBuilder: (BuildContext context, int i) => RequestsItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
