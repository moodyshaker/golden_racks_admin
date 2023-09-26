import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/agenda_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/widgets/technical_ticket_view_screen.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

class DayTicketItem extends StatelessWidget {
  final AgendaModel dailyTask;

  const DayTicketItem({required this.dailyTask});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: () {
          MagicRouter.navigateTo(
            TechnicalTicketViewScreen(dailyTicket: dailyTask),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainText(
              text: 'تذكرة رقم ',
              font: 12.sp,
              color: Colors.black,
              weight: FontWeight.w900,
              family: 'Lato',
            ),
            SizedBox(width: 4.w),
            MainText(
              text: '${dailyTask.ticketNumber}',
              font: 12.sp,
              color: Colors.black,
              weight: FontWeight.w400,
              family: 'Lato',
            ),
          ],
        ),
      ),
    );
  }
}
