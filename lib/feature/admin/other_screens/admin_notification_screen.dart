import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_daily_tasks.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/notification_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

class AdminNotificationScreen extends StatefulWidget {
  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  @override
  void initState() {
    super.initState();
    DailyTasksProvider.listenFalse(context).getNotification(
      userId: Preferences.instance.getUserId,
      // userId: 'e2e2f098-1e3c-4ce0-949e-55e6837436f5',
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyTasksProvider = DailyTasksProvider.get(context);

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
        title1: 'الاشعارات',
        body: dailyTasksProvider.notificationStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : dailyTasksProvider.notificationStatus == NetworkStatus.success
                ? dailyTasksProvider.allNotifications.isEmpty
                    ? Center(
                        child: MainText(
                          text: 'لا يوجد اشعارات',
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          itemBuilder: (BuildContext context, int i) =>
                              NotificationItem(
                            notification:
                                dailyTasksProvider.allNotifications[i],
                          ),
                          itemCount: dailyTasksProvider.allNotifications.length,
                        ),
                      )
                : RetryWidget(
                    retryCallback: () async {
                      await dailyTasksProvider.getNotification(
                        userId: Preferences.instance.getUserId,
                        retry: true,
                      );
                    },
                  ),
      ),
    );
  }
}
