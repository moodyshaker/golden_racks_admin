import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_sub_emergency_plan.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import 'requests_item_sub_emergency.dart';

class SubscribersEmergencyRequestsAdminScreen extends StatefulWidget {
  @override
  State<SubscribersEmergencyRequestsAdminScreen> createState() =>
      _SubscribersEmergencyRequestsAdminScreenState();
}

class _SubscribersEmergencyRequestsAdminScreenState
    extends State<SubscribersEmergencyRequestsAdminScreen> {
  @override
  void initState() {
    super.initState();
    AssignToSubEmergencyProvider.listenFalse(context).getEmergencySubPlans();
  }

  @override
  Widget build(BuildContext context) {
    final emergencySubProvider = AssignToSubEmergencyProvider.get(context);

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
        hasNavBar: true,
        title1: 'تحديد فني لطلبات الطوارئ للمشتركين',
        body: emergencySubProvider.emergencySubStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : emergencySubProvider.emergencySubStatus == NetworkStatus.success
                ? emergencySubProvider.emergencySubPlans.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: MainText(
                          text: 'لا يوجد خطط',
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) {
                          return RequestsItemsubEmergency(
                            emergencySub:
                                emergencySubProvider.emergencySubPlans[i],
                          );
                        },
                        itemCount:
                            emergencySubProvider.emergencySubPlans.length,
                      )
                : RetryWidget(
                    retryCallback: () async {
                      await emergencySubProvider.getEmergencySubPlans(
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
