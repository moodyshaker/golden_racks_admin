import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/subscribers_request_item.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/need_activate_item.dart';
import '../widgets/requests_item.dart';

class UnSubscribersEmergencyRequestsScreen extends StatefulWidget {
  const UnSubscribersEmergencyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersEmergencyRequestsScreen> createState() => _UnSubscribersEmergencyRequestsScreenState();
}

class _UnSubscribersEmergencyRequestsScreenState extends State<UnSubscribersEmergencyRequestsScreen> {
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
        hasAppbar:false,
        isHome: true,
        hasNavBar: false,
        title1: 'تحديد فني لطلبات الطوارئ لغير المشتركين',
        body: Expanded(
          child: ListView.builder(
            padding:
            EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => RequestsItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
