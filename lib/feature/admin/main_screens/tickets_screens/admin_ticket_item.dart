// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/localization/demo_localization.dart';
import 'package:golden_racks_admin/core/models/admin_tickets_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/tickets_screens/admin_ticket_view_screen.dart';
import 'package:golden_racks_admin/feature/widgets/action_dialog.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';

class AdminTicketItem extends StatelessWidget {
  final AdminTicketsModel adminTicket;
  AdminTicketItem({
    required this.adminTicket,
  });

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.h),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(getAsset('plan_background')), fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainText(
                text: 'شركة ${adminTicket.companyName}',
                font: 15.sp,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
              MainText(
                text: 'رقم التذكرة  ${adminTicket.ticketNumber}',
                font: 15.sp,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          ),
          Divider(
            height: 8.h,
            color: gray_60,
            thickness: 1,
          ),
          MainText(
            text: '${adminTicket.problemName}',
            font: 16.sp,
            weight: FontWeight.w700,
            color: Colors.black,
          ),
          SizedBox(
            height: 13.h,
          ),
          Column(
            children: [
              Row(
                children: [
                  MainText(
                    text: demo.getTranslatedValue('the_technician'),
                    font: 15.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: MainText(
                      text: '${adminTicket.technicalName}',
                      font: 15.sp,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MainText(
                    text: demo.getTranslatedValue('the_date'),
                    font: 15.sp,
                    weight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: MainText(
                      text: formateDateTimeToDate(adminTicket.createdDate!),
                      font: 15.sp,
                      weight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 8.h,
            color: gray_60,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container()),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: InkWell(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.brown,
                      ),
                      child: Center(
                        child: MainText(
                          text: 'تفاصيل الزيارة',
                          color: Colors.white,
                          font: 15.sp,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (adminTicket.visitDetails == null) {
                        showDialog(
                          context: context,
                          builder: (_) => ActionDialog(
                            content: 'هذه التذكرة لا تحتوي علي تفاصيل للزيارة',
                            approveAction: 'حسنا',
                            onApproveClick: MagicRouter.pop,
                          ),
                        );
                      } else {
                        MagicRouter.navigateTo(AdminTicketViewScreen(
                          visitDetails: adminTicket.visitDetails!,
                          ticketNumber: adminTicket.ticketNumber!,
                          companyName: adminTicket.companyName!,
                          technicalName: adminTicket.technicalName!,
                        ));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
