import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_search_tickets.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/search_ticket_item.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class SearchTicketsScreen extends StatefulWidget {
  const SearchTicketsScreen({Key? key}) : super(key: key);

  @override
  State<SearchTicketsScreen> createState() => _SearchTicketsScreenState();
}

class _SearchTicketsScreenState extends State<SearchTicketsScreen> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSearchTickets(
      technicalId: Preferences.instance.getUserId,
      ticketType: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: TechnicianCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: true,
        // title1: 'اهلا وسهلا',
        title2: 'فني ${Preferences.instance.getUserFullName}',
        title3: '',
        isHome: true,
        hasNavBar: true,
        pic: 'profile',
        title1: 'التذاكر',
        body: SearchTicketWidget(),
      ),
    );
  }
}

class SearchTicketWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);

    return DefaultTabController(
      length: 4,
      child: searchTicketProvider.searchTicketStatus == NetworkStatus.loading
          ? OpacityLoadingLogo()
          : searchTicketProvider.searchTicketStatus == NetworkStatus.success
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTabBar(),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            children: [
                              TicketTypeNew(),
                              TicketTypeWorking(),
                              TicketTypeFinished(),
                              TicketTypeAll(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RetryWidget(
                  retryCallback: () async {
                    await searchTicketProvider.getSearchTickets(
                      technicalId: Preferences.instance.getUserId,
                      ticketType: 0,
                      retry: true,
                    );
                  },
                ),
    );
  }
}

class TicketTypeAll extends StatefulWidget {
  @override
  State<TicketTypeAll> createState() => _TicketTypeAllState();
}

class _TicketTypeAllState extends State<TicketTypeAll> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSearchTickets(
      technicalId: Preferences.instance.getUserId,
      ticketType: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);

    return searchTicketProvider.allSearchTickets.isEmpty
        ? Center(
            child: MainText(
              text: 'لا يوجد تذاكر',
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => SearchTicketItem(
              searchTicket: searchTicketProvider.allSearchTickets[i],
            ),
            itemCount: searchTicketProvider.allSearchTickets.length,
          );
  }
}

class TicketTypeFinished extends StatefulWidget {
  @override
  State<TicketTypeFinished> createState() => _TicketTypeFinishedState();
}

class _TicketTypeFinishedState extends State<TicketTypeFinished> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSearchTickets(
      technicalId: Preferences.instance.getUserId,
      ticketType: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);

    return searchTicketProvider.searchTicketStatus == NetworkStatus.loading
        ? OpacityLoadingLogo()
        : searchTicketProvider.searchTicketStatus == NetworkStatus.success
            ? searchTicketProvider.allSearchTickets.isEmpty
                ? Center(
                    child: MainText(
                      text: 'لا يوجد تذاكر منتهية',
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    itemBuilder: (BuildContext context, int i) =>
                        SearchTicketItem(
                      searchTicket: searchTicketProvider.allSearchTickets[i],
                    ),
                    itemCount: searchTicketProvider.allSearchTickets.length,
                  )
            : RetryWidget(
                retryCallback: () async {
                  await searchTicketProvider.getSearchTickets(
                    technicalId: Preferences.instance.getUserId,
                    ticketType: 3,
                    retry: true,
                  );
                },
              );
  }
}

class TicketTypeWorking extends StatefulWidget {
  @override
  State<TicketTypeWorking> createState() => _TicketTypeWorkingState();
}

class _TicketTypeWorkingState extends State<TicketTypeWorking> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSearchTickets(
      technicalId: Preferences.instance.getUserId,
      ticketType: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);

    return searchTicketProvider.searchTicketStatus == NetworkStatus.loading
        ? OpacityLoadingLogo()
        : searchTicketProvider.searchTicketStatus == NetworkStatus.success
            ? searchTicketProvider.allSearchTickets.isEmpty
                ? Center(
                    child: MainText(
                      text: 'لا يوجد تذاكر تحت التشغيل',
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    itemBuilder: (BuildContext context, int i) =>
                        SearchTicketItem(
                      searchTicket: searchTicketProvider.allSearchTickets[i],
                    ),
                    itemCount: searchTicketProvider.allSearchTickets.length,
                  )
            : RetryWidget(
                retryCallback: () async {
                  await searchTicketProvider.getSearchTickets(
                    technicalId: Preferences.instance.getUserId,
                    ticketType: 2,
                    retry: true,
                  );
                },
              );
  }
}

class TicketTypeNew extends StatefulWidget {
  @override
  State<TicketTypeNew> createState() => _TicketTypeNewState();
}

class _TicketTypeNewState extends State<TicketTypeNew> {
  @override
  void initState() {
    super.initState();
    SearchTicketProvider.listenFalse(context).getSearchTickets(
      technicalId: Preferences.instance.getUserId,
      ticketType: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchTicketProvider = SearchTicketProvider.get(context);

    return searchTicketProvider.searchTicketStatus == NetworkStatus.loading
        ? OpacityLoadingLogo()
        : searchTicketProvider.searchTicketStatus == NetworkStatus.success
            ? searchTicketProvider.allSearchTickets.isEmpty
                ? Center(
                    child: MainText(
                      text: 'لا يوجد تذاكر جديدة',
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    itemBuilder: (BuildContext context, int i) =>
                        SearchTicketItem(
                      searchTicket: searchTicketProvider.allSearchTickets[i],
                    ),
                    itemCount: searchTicketProvider.allSearchTickets.length,
                  )
            : RetryWidget(
                retryCallback: () async {
                  await searchTicketProvider.getSearchTickets(
                    technicalId: Preferences.instance.getUserId,
                    ticketType: 1,
                    retry: true,
                  );
                },
              );
  }
}

class CustomTabBar extends StatefulWidget {
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        indicator: ShapeDecoration(
          color: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        tabs: [
          Tab(
            child: MainText(
              color: Colors.black,
              text: 'جديد',
              font: 16.sp,
              weight: FontWeight.w700,
            ),
          ),
          Tab(
            child: MainText(
              color: Colors.black,
              text: 'تحت التشغيل',
              font: 16.sp,
              weight: FontWeight.w700,
            ),
          ),
          Tab(
            child: MainText(
              color: Colors.black,
              text: 'منتهية',
              font: 16.sp,
              weight: FontWeight.w700,
            ),
          ),
          Tab(
            child: MainText(
              color: Colors.black,
              text: 'الجميع',
              font: 16.sp,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
