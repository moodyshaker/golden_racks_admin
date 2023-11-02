import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_auth.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/active_plan_screens/activate_plane_admin_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribe_emergency_admin_screens/subscribers_emergency_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribe_ready_admin_screens/subscribers_ready_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_emergency_admin_screens/unsubscribers_emergency_requests_screen.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_normal_admin_screens/unsubscribers_normal_requests_screen.dart';
import 'package:golden_racks_admin/feature/widgets/customButton.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import '../../../widgets/main_text.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
    AuthProvider.listenFalse(context).getStatistics();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = AuthProvider.get(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            getAsset('background1'),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        isHome: true,
        hasAppbar: true,
        title1: 'اهلا وسهلا',
        title2: 'Administrator',
        title3: '',
        pic: 'profile',
        hasNavBar: true,
        body: authProvider.statisticsStatus == NetworkStatus.loading
            ? OpacityLoadingLogo()
            : authProvider.statisticsStatus == NetworkStatus.success
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        MainText(
                          text: 'القائمة الرئيسية',
                          font: 20.sp,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 10.h),
                            children: [
                              NewApplicantWidget(
                                title: 'حسابات في انتظار تفعيل الخطط لها',
                                number:
                                    mainStatistics.numberOfWaitingActivation!,
                                onPress: () async {
                                  MagicRouter.navigateTo(
                                      ActivatePlanAdminScreen());
                                },
                              ),
                              NewApplicantWidget(
                                title: 'طلبات الطوارئ للمشتركين',
                                number:
                                    mainStatistics.numberOfSubscriberEmergency!,
                                onPress: () async {
                                  MagicRouter.navigateTo(
                                      SubscribersEmergencyRequestsAdminScreen());
                                },
                              ),
                              NewApplicantWidget(
                                title: 'طلبات الدورية للمشتركين',
                                number: mainStatistics
                                    .numberOfSubscriberNormalComeFromSystem!,
                                onPress: () async {
                                  MagicRouter.navigateTo(
                                      SubscribersReadyRequestsAdminScreen());
                                },
                              ),
                              NewApplicantWidget(
                                title: 'طلبات الطوارئ لغير المشتركين',
                                number: mainStatistics
                                    .numberOfUnSubscriberEmergency!,
                                onPress: () async {
                                  MagicRouter.navigateTo(
                                      UnSubscribersEmergencyRequestsAdminScreen());
                                },
                              ),
                              NewApplicantWidget(
                                title: 'طلبات الدورية لغير المشتركين',
                                number:
                                    mainStatistics.numberOfUnSubscriberNormal!,
                                onPress: () async {
                                  MagicRouter.navigateTo(
                                      UnSubscribersNormalRequestsAdminScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : RetryWidget(
                    retryCallback: () async {
                      await authProvider.getStatistics(retry: true);
                    },
                  ),
      ),
    );
  }
}

class NewApplicantWidget extends StatelessWidget {
  final String title;
  final int number;
  final Function() onPress;

  const NewApplicantWidget({
    required this.title,
    required this.number,
    required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: '${title}',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
                MainText(
                  text: '${number}',
                  font: 50.sp,
                  weight: FontWeight.w700,
                  color: mainColor,
                ),
                MainText(
                  text: 'طلب جديد',
                  font: 12.sp,
                  weight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          CustomButton(
            title: 'عرض',
            color: kSecondaryColor,
            radius: 8.r,
            height: 42.h,
            width: 95.w,
            font: 16.sp,
            family: 'Lato_bold',
            textColor: Colors.white,
            withBorder: false,
            onPressed: onPress,
          ),
        ],
      ),
    );
  }
}
