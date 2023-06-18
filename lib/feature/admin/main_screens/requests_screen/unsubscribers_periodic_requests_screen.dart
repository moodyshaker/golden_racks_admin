import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/requests_item.dart';

class UnSubscribersPeriodicRequestsScreen extends StatefulWidget {
  const UnSubscribersPeriodicRequestsScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersPeriodicRequestsScreen> createState() => _UnSubscribersPeriodicRequestsScreenState();
}

class _UnSubscribersPeriodicRequestsScreenState extends State<UnSubscribersPeriodicRequestsScreen> {
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
        title1: 'تحديد فني لطلبات الدورية لغير المشتركين',
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
