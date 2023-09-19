import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_emergency_plan.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import 'requests_item_unsub_emergency.dart';

class UnSubscribersEmergencyRequestsAdminScreen extends StatefulWidget {
  @override
  State<UnSubscribersEmergencyRequestsAdminScreen> createState() =>
      _UnSubscribersEmergencyRequestsAdminScreenState();
}

class _UnSubscribersEmergencyRequestsAdminScreenState
    extends State<UnSubscribersEmergencyRequestsAdminScreen> {
  @override
  void initState() {
    super.initState();
    AssignToUnsubEmergencyProvider.listenFalse(context)
        .getEmergencyUnsubPlans();
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
        body: emergencyUnsubProvider.emergencyUnsubStatus ==
                NetworkStatus.loading
            ? OpacityLoadingLogo()
            : emergencyUnsubProvider.emergencyUnsubStatus ==
                    NetworkStatus.success
                ? emergencyUnsubProvider.emergencyUnsubPlans.isEmpty
                    ? Container(
                        child: MainText(
                          text: 'لا يوجد خطط طوارئ',
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) {
                          return RequestsItemUnsubEmergency(
                            emergencyUnsub:
                                emergencyUnsubProvider.emergencyUnsubPlans[i],
                          );
                        },
                        itemCount:
                            emergencyUnsubProvider.emergencyUnsubPlans.length,
                      )
                : RetryWidget(
                    retryCallback: () async {
                      await emergencyUnsubProvider.getEmergencyUnsubPlans(
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
