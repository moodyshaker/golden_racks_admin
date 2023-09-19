import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/models/normal_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_normal_plan.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_normal_admin_screens/admin_assign_technical_screen_for_normal_unsub.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_normal_admin_screens/normal_unsub_ticket_view_screen.dart';
import '../../../../constants.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/main_text.dart';

class RequestsItemUnsubNormal extends StatefulWidget {
  final NormalPlanUnSubModel normalUnsub;

  const RequestsItemUnsubNormal({required this.normalUnsub});
  @override
  State<RequestsItemUnsubNormal> createState() =>
      _RequestsItemUnsubNormalState();
}

class _RequestsItemUnsubNormalState extends State<RequestsItemUnsubNormal> {
  @override
  Widget build(BuildContext context) {
    final normalUnsubProvider = AssignToUnsubNormalProvider.get(context);
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
                          text: '${widget.normalUnsub.companyName_Ar}',
                          font: 15.sp,
                          weight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        MainText(
                          text: '${widget.normalUnsub.accountNumber}',
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
                          text: '${widget.normalUnsub.ticketNumber!}',
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
                text: '${widget.normalUnsub.problemName}',
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
                            '${widget.normalUnsub.addedDate}'),
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
                            '${widget.normalUnsub.addedDate}'),
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
                  text: '${widget.normalUnsub.address}',
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
            children: [
              CustomButton(
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
                  MagicRouter.navigateTo(NormalUnsubTicketViewScreen(
                    normalUnsub: widget.normalUnsub,
                  ));
                },
              ),
              SizedBox(
                width: 5.w,
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
                      AdminAssignTechnicalForNormalUnsubScreen(
                        normalUnsub: widget.normalUnsub,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomButton(
                horizontalPadding: 15.w,
                title: 'رفض',
                color: Colors.red,
                height: 50.h,
                font: 16.sp,
                weight: FontWeight.w800,
                family: 'Lato_bold',
                textColor: Colors.white,
                withBorder: false,
                onPressed: () async {
                  await normalUnsubProvider.refuseNormalUnsubPlan(
                    id: widget.normalUnsub.id!,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
