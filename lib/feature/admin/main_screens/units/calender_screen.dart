import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants.dart';
import '../../../../core/bloc/app_cubit.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../../core/localization/demo_localization.dart';
import '../../../widgets/main_text.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  void initState() {
    super.initState();
    HomeCubit.listenFalse(context).getEventCategory();
  }

  @override
  Widget build(BuildContext context) {
    final demo = DemoLocalization.of(context);
    final cubit = AppCubit.get(context);
    final home = HomeCubit.get(context);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(getAsset('background2')), fit: BoxFit.fill)),
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          MainText(
            text: 'مواعيد الزيارة الدورية للخطة',
            color: Colors.black,
          ),
          SizedBox(
            height: 16.h,
          ),
          Theme(
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
        ],
      )),
    );
  }
}
