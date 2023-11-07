import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/models/agenda_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/provider/provider_daily_tasks.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/agenda_ticket_view_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/day_ticket_item.dart';
import 'package:golden_racks_admin/feature/widgets/opacity_loading_logo.dart';
import 'package:golden_racks_admin/feature/widgets/retry_widget.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';
import '../../../widgets/main_text.dart';

class TechnicianMain extends StatefulWidget {
  @override
  State<TechnicianMain> createState() => _TechnicianMainState();
}

class _TechnicianMainState extends State<TechnicianMain> {
  DateTime? selectedDate;
  Preferences _preferences = Preferences.instance;

  @override
  void initState() {
    super.initState();
    DailyTasksProvider.listenFalse(context)
        .getAllAgendas(technicalId: _preferences.getUserId);
    DailyTasksProvider.listenFalse(context)
        .getAllDailyTasks(technicalId: _preferences.getUserId);
  }

  @override
  Widget build(BuildContext context) {
    final dailyTasksProvider = DailyTasksProvider.get(context);

    var datesList = dailyTasksProvider.allAgendas
        .map((e) => DateTime.parse(e.visitDate!))
        .toList();

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            getAsset('background1'),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: TechnicianCustomScaffold(
        backgroundColor: Colors.transparent,
        isHome: true,
        hasAppbar: true,
        title1: 'اهلا وسهلا',
        title2: 'فني ${Preferences.instance.getUserFullName}',
        title3: '',
        pic: 'profile',
        hasNavBar: true,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: dailyTasksProvider.agendaStatus == NetworkStatus.loading ||
                  dailyTasksProvider.dailyTasksStatus == NetworkStatus.loading
              ? OpacityLoadingLogo()
              : dailyTasksProvider.agendaStatus == NetworkStatus.success &&
                      dailyTasksProvider.dailyTasksStatus ==
                          NetworkStatus.success
                  ? Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                MainText(
                                  text: 'الاجندة',
                                  font: 16.sp,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                dailyTasksProvider.allAgendas.isEmpty
                                    ? Center(
                                        child: MainText(
                                          text: 'لا يوجد اي مواعيد',
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          border: Border.all(
                                              width: 1, color: Colors.black),
                                        ),
                                        child: Theme(
                                          data: ThemeData.light().copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: Colors.brown,
                                              onPrimary: Colors.white,
                                              surface: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                          ),
                                          child: CalendarDatePicker2(
                                            config: CalendarDatePicker2Config(
                                              calendarType:
                                                  CalendarDatePicker2Type.multi,
                                            ),
                                            value: datesList,
                                            onValueChanged: (dates) {
                                              for (var date in datesList) {
                                                if (!dates.contains(date)) {
                                                  selectedDate = date;

                                                  AgendaModel foundedAgenda =
                                                      dailyTasksProvider
                                                          .allAgendas
                                                          .firstWhere(
                                                    (e) =>
                                                        DateTime.parse(
                                                          e.visitDate!,
                                                        ) ==
                                                        selectedDate,
                                                  );

                                                  MagicRouter.navigateTo(
                                                    AgendaTicketView(
                                                      agendaTicket:
                                                          foundedAgenda,
                                                    ),
                                                  );
                                                }
                                              }
                                              return;
                                            },
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                MainText(
                                  text: 'مهام اليوم',
                                  font: 16.sp,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(height: 8.h),
                                dailyTasksProvider.allDailyTasks.isEmpty
                                    ? Center(
                                        child: MainText(
                                          text: 'لا توجد مهام اليوم',
                                        ),
                                      )
                                    : Container(
                                        height: 123.h,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: ListView.builder(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                          ),
                                          itemBuilder:
                                              (BuildContext context, int i) =>
                                                  DayTicketItem(
                                            dailyTask: dailyTasksProvider
                                                .allDailyTasks[i],
                                          ),
                                          itemCount: dailyTasksProvider
                                              .allDailyTasks.length,
                                        ),
                                      ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : RetryWidget(
                      retryCallback: () async {
                        await dailyTasksProvider.getAllAgendas(
                          technicalId: _preferences.getUserId,
                          retry: true,
                        );
                        await dailyTasksProvider.getAllDailyTasks(
                          technicalId: _preferences.getUserId,
                          retry: true,
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
