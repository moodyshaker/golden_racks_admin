import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/requests_item_unsub_emergency_tech.dart';

import '../../../constants.dart';
import '../../../core/bloc/home_cubit.dart';
import '../../widgets/organizerCustomScaffold.dart';

class UnSubscribersPeriodicRequestsTechScreen extends StatefulWidget {
  const UnSubscribersPeriodicRequestsTechScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersPeriodicRequestsTechScreen> createState() =>
      _UnSubscribersPeriodicRequestsTechScreenState();
}

class _UnSubscribersPeriodicRequestsTechScreenState
    extends State<UnSubscribersPeriodicRequestsTechScreen> {
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
        title1: 'تحديد فني لطلبات الدورية لغير المشتركين',
        body: Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) =>
                RequestsItemUnsubEmergencyTech(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
