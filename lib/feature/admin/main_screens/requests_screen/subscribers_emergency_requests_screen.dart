import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/requests_item.dart';
import '../widgets/subdcribers_requests_item.dart';

class SubscribersEmergencyRequestsScreen extends StatefulWidget {
  const SubscribersEmergencyRequestsScreen({Key? key}) : super(key: key);

  @override
  State<SubscribersEmergencyRequestsScreen> createState() => _SubscribersEmergencyRequestsScreenState();
}

class _SubscribersEmergencyRequestsScreenState extends State<SubscribersEmergencyRequestsScreen> {
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
        hasAppbar:false,
        isHome: true,
        hasNavBar: false,
        title1: 'تحديد فني لطلبات الطوارئ للمشتركين',
        body: Expanded(
          child: ListView.builder(
            padding:
            EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => SubscribersRequestsItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
