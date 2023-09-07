import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_emergency_plan.dart';
import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/requests_item.dart';

class UnSubscribersEmergencyRequestsAdminScreen extends StatefulWidget {
  const UnSubscribersEmergencyRequestsAdminScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersEmergencyRequestsAdminScreen> createState() =>
      _UnSubscribersEmergencyRequestsAdminScreenState();
}

class _UnSubscribersEmergencyRequestsAdminScreenState
    extends State<UnSubscribersEmergencyRequestsAdminScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emergencyUnsubProvider = AssignToUnsubEmergencyProvider.get(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            getAsset('background2'),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
        title1: 'تحديد فني لطلبات الطوارئ لغير المشتركين',
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          itemBuilder: (BuildContext context, int i) {
            emergencyUnsubProvider.choosedEmergencyUnsubPlan =
                emergencyUnsubProvider.emergencyUnsubPlans[i];
            return RequestsItem();
          },
          itemCount: emergencyUnsubProvider.emergencyUnsubPlans.length,
        ),
      ),
    );
  }
}
