import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_admin_tickets.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/tickets_screens/admin_ticket_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';

class AdminTicketsScreen extends StatefulWidget {
  @override
  State<AdminTicketsScreen> createState() => _AdminTicketsScreenState();
}

class _AdminTicketsScreenState extends State<AdminTicketsScreen> {
  @override
  void initState() {
    super.initState();
    AdminTicketsProvider.listenFalse(context).getallAdminTickets();
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final adminTicketProvider = AdminTicketsProvider.get(context);

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
        title1: demo.getTranslatedValue('hello'),
        title2: '${Preferences.instance.getUserFullName}',
        title3: '',
        pic: 'profile',
        hasNavBar: true,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                horizontalPadding: 12.w,
                text: 'التذاكر',
                font: 14.sp,
                weight: FontWeight.w800,
                color: Colors.black,
              ),
              SizedBox(
                height: 8.h,
              ),
              Expanded(
                child: adminTicketProvider.adminTicketsStatus ==
                        NetworkStatus.loading
                    ? OpacityLoadingLogo()
                    : adminTicketProvider.adminTicketsStatus ==
                            NetworkStatus.success
                        ? adminTicketProvider.allAdminTickets.isEmpty
                            ? Center(
                                child: MainText(text: 'لا يوجد تذاكر سابقة'),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 10.h),
                                itemBuilder: (BuildContext context, int i) =>
                                    AdminTicketItem(
                                  adminTicket:
                                      adminTicketProvider.allAdminTickets[i],
                                ),
                                itemCount:
                                    adminTicketProvider.allAdminTickets.length,
                              )
                        : RetryWidget(
                            retryCallback: () async {
                              await adminTicketProvider.getallAdminTickets(
                                retry: true,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
