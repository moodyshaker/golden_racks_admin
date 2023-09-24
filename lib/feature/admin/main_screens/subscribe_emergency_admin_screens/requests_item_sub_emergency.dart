import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_sub_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribe_emergency_admin_screens/admin_assign_technical_screen_for_emergency_sub.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/subscribe_emergency_admin_screens/emergency_sub_ticket_view_screen.dart';
import '../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class RequestsItemsubEmergency extends StatefulWidget {
  final EmergencyPlanSubModel emergencySub;

  const RequestsItemsubEmergency({required this.emergencySub});
  @override
  State<RequestsItemsubEmergency> createState() =>
      _RequestsItemsubEmergencyState();
}

class _RequestsItemsubEmergencyState extends State<RequestsItemsubEmergency> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: gray_20,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1.0, color: kInactiveColor),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 9.h,
          ),
          Row(
            children: [
              Container(
                height: 38.h,
                width: 38.w,
                child: Image.asset(
                  getAsset('defualt_pic'),
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        MainText(
                          text: '${widget.emergencySub.companyName_Ar}',
                          font: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        MainText(
                          text: '${widget.emergencySub.accountNumber}',
                          font: 14.sp,
                          weight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MainText(
                          text: 'رقم التذكرة',
                          font: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        MainText(
                          text: '${widget.emergencySub.ticketNumber}',
                          font: 14.sp,
                          weight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 9.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              MainText(
                text: 'العطل',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 27.w,
              ),
              MainText(
                text: '${widget.emergencySub.problemName}',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w500,
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Row(
                  children: [
                    MainText(
                      text: 'التاريخ',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Flexible(
                      child: MainText(
                        text: formateDateTimeToDate(
                            '${widget.emergencySub.addedDate}'),
                        font: 15.sp,
                        color: Colors.black,
                        weight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: [
                    MainText(
                      text: 'وقت',
                      font: 15.sp,
                      color: Colors.black,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: MainText(
                        text: formateDateTimeToTime(
                            '${widget.emergencySub.addedDate}'),
                        font: 15.sp,
                        color: Colors.black,
                        weight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 8.w,
              ),
              MainText(
                text: 'عنوان',
                font: 15.sp,
                color: Colors.black,
                weight: FontWeight.w700,
              ),
              SizedBox(
                width: 27.w,
              ),
              Flexible(
                child: MainText(
                  text: '${widget.emergencySub.address}',
                  font: 15.sp,
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  horizontalPadding: 8.w,
                  title: 'عرض التذكرة',
                  color: kSecondaryColor,
                  height: 50.h,
                  font: 12.sp,
                  family: 'Lato_bold',
                  textColor: Colors.white,
                  weight: FontWeight.w800,
                  withBorder: false,
                  onPressed: () async {
                    MagicRouter.navigateTo(EmergencySubTicketViewScreen(
                      emergencySub: widget.emergencySub,
                    ));
                  },
                ),
              ),
              SizedBox(
                width: 36.w,
              ),
              Expanded(
                child: CustomButton(
                  title: 'تخصيص فني',
                  color: Colors.transparent,
                  height: 50.h,
                  font: 16.sp,
                  family: 'Lato_bold',
                  weight: FontWeight.w800,
                  textColor: Colors.black,
                  withBorder: true,
                  borderWidth: 1.0,
                  borderColor: gray_40,
                  onPressed: () async {
                    MagicRouter.navigateTo(
                      AdminAssignTechnicalForEmergencySubScreen(
                        emergencySub: widget.emergencySub,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
