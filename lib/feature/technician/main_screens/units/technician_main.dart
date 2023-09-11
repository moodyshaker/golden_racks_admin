import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/day_ticket_item.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/tickets_screen.dart';
import '../../../widgets/main_text.dart';

class TechnicianMain extends StatefulWidget {
  const TechnicianMain({Key? key}) : super(key: key);

  @override
  State<TechnicianMain> createState() => _TechnicianMainState();
}

class _TechnicianMainState extends State<TechnicianMain> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.brown,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.brown,
                        ),
                      ),
                      child: CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime.utc(1980, 01, 1, 1, 1, 1, 1),
                          lastDate: DateTime.utc(2050, 01, 1, 1, 1, 1, 1),
                          onDateChanged: (date) {
                            log('${date}');
                          }),
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
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      MagicRouter.navigateTo(TicketsScreen());
                    },
                    child: Container(
                      height: 123.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        itemBuilder: (BuildContext context, int i) =>
                            DayTicketItem(),
                        itemCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
