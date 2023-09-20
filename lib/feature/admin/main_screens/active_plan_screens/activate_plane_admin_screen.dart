import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_active_plan.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/active_plan_screens/need_activate_item_admin.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class ActivatePlanAdminScreen extends StatefulWidget {
  const ActivatePlanAdminScreen({Key? key}) : super(key: key);

  @override
  State<ActivatePlanAdminScreen> createState() =>
      _ActivatePlanAdminScreenState();
}

class _ActivatePlanAdminScreenState extends State<ActivatePlanAdminScreen> {
  @override
  void initState() {
    ActivePlanProvider.listenFalse(context).getAllUnActivePlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activePlanProvider = ActivePlanProvider.get(context);

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
        title1: 'حسابات في انتظار تفعيل الخطط لها',
        body: activePlanProvider.unActivePlanStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : activePlanProvider.unActivePlanStatus == NetworkStatus.success
                ? activePlanProvider.allUnActivePlans.isEmpty
                    ? Container(
                        child: MainText(
                          text: 'لا يوجد طلبات تفعيل للخطط',
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) =>
                            NeedActivateItemAdmin(
                          unActivePlan: activePlanProvider.allUnActivePlans[i],
                        ),
                        itemCount: activePlanProvider.allUnActivePlans.length,
                      )
                : RetryWidget(
                    retryCallback: () async {
                      await activePlanProvider.getAllUnActivePlans(
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
