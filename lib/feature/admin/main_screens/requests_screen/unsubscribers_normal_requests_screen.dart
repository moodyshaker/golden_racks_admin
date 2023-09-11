import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_normal_plan.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/requests_item_unsub_normal.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class UnSubscribersNormalRequestsAdminScreen extends StatefulWidget {
  @override
  State<UnSubscribersNormalRequestsAdminScreen> createState() =>
      _UnSubscribersNormalRequestsAdminScreenState();
}

class _UnSubscribersNormalRequestsAdminScreenState
    extends State<UnSubscribersNormalRequestsAdminScreen> {
  @override
  void initState() {
    super.initState();
    AssignToUnsubNormalProvider.listenFalse(context).getNormalUnsubPlans();
  }

  @override
  Widget build(BuildContext context) {
    final NormalUnsubProvider = AssignToUnsubNormalProvider.get(context);

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
        title1: 'تحديد فني لطلبات الدورية لغير المشتركين',
        body: NormalUnsubProvider.normalUnsubStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : NormalUnsubProvider.normalUnsubStatus == NetworkStatus.success
                ? NormalUnsubProvider.normalUnsubPlans.isEmpty
                    ? Container(
                        child: MainText(
                          text: 'لا يوجد خطط دورية',
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) {
                          return RequestsItemUnsubNormal(
                            normalUnsub:
                                NormalUnsubProvider.normalUnsubPlans[i],
                          );
                        },
                        itemCount: NormalUnsubProvider.normalUnsubPlans.length,
                      )
                : RetryWidget(
                    retryCallback: () {
                      NormalUnsubProvider.getNormalUnsubPlans(
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
