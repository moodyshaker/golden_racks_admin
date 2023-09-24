import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_sub_ready_plan.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../../constants.dart';
import 'requests_item_sub_ready.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class SubscribersReadyRequestsAdminScreen extends StatefulWidget {
  const SubscribersReadyRequestsAdminScreen({Key? key}) : super(key: key);

  @override
  State<SubscribersReadyRequestsAdminScreen> createState() =>
      _SubscribersReadyRequestsAdminScreenState();
}

class _SubscribersReadyRequestsAdminScreenState
    extends State<SubscribersReadyRequestsAdminScreen> {
  @override
  void initState() {
    super.initState();
    AssignToSubReadyProvider.listenFalse(context).getReadySubPlans();
  }

  @override
  Widget build(BuildContext context) {
    final readySubProvider = AssignToSubReadyProvider.get(context);

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
        hasNavBar: true,
        title1: 'تحديد فني لطلبات الصيانة الدورية للمشتركين',
        body: readySubProvider.readySubStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : readySubProvider.readySubStatus == NetworkStatus.success
                ? readySubProvider.todayAppointments.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: MainText(
                          text: 'لا يوجد خطط',
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) {
                          return RequestsItemSubReady(
                            appointment: readySubProvider.todayAppointments[i],
                          );
                        },
                        itemCount: readySubProvider.todayAppointments.length,
                      )
                : RetryWidget(
                    retryCallback: () async {
                      await readySubProvider.getReadySubPlans(
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
