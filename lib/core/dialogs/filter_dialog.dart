import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../feature/widgets/custom_filter_checkbox.dart';
import '../../feature/widgets/default_filter_checkbox.dart';
import '../../feature/widgets/main_text.dart';
import '../bloc/home_cubit.dart';
import '../router/router.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool _isFree = false;
  DateTime? _to, _from;

  @override
  Widget build(BuildContext context) {
    final home = HomeCubit.get(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                height: 80.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kMainColor, kMainLighterColor])),
                child: Row(
                  children: [
                    Expanded(
                        child: MainText(
                            text: 'تصفية المؤتمرات', color: kAccentColor)),
                    TextButton(
                      onPressed: () async {
                        home.setCurrentEventEnum(EventEnum.main);
                        MagicRouter.pop();
                        await home.getEventList();
                      },
                      child: MainText(
                        text: 'عرض الجميع',
                        color: kAccentColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultCheckbox(
                      onCheck: (bool v) {
                        _isFree = v;
                        log('${_isFree}');
                      },
                      content: 'مجاني',
                      leftCheckbox: false,
                      rightCheckRightMargin: 0.w,
                      rightCheckbox: true,
                      textColor: kBlackColor,
                      weight: FontWeight.bold,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext ctx, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                dialogTheme: DialogTheme(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      25.0,
                                    ),
                                  ),
                                ),
                                colorScheme: ColorScheme.light(
                                  primary: kMainColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: kMainColor,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (dt != null) {
                          setState(() {
                            _from = dt;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          MainText(
                              text: _from != null
                                  ? DateFormat('dd-mm-yyyy').format(_from!)
                                  : 'من الفترة',
                              font: 15.sp,
                              weight: FontWeight.bold,
                              color: kBlackColor),
                          SizedBox(
                            width: 4.w,
                          ),
                          Image.asset(
                            getAsset('calendar_with_point'),
                            height: 24.h,
                            width: 24.w,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext ctx, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                dialogTheme: DialogTheme(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      25.0,
                                    ),
                                  ),
                                ),
                                colorScheme: ColorScheme.light(
                                  primary: kMainColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: kMainColor,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (dt != null) {
                          setState(() {
                            _to = dt;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          MainText(
                              text: _to != null
                                  ? DateFormat('dd-mm-yyyy').format(_to!)
                                  : 'إلي الفترة',
                              font: 15.sp,
                              weight: FontWeight.bold,
                              color: kBlackColor),
                          SizedBox(
                            width: 4.w,
                          ),
                          Image.asset(
                            getAsset('calendar_with_point'),
                            height: 24.h,
                            width: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: home.eventsCategory!.length,
                  separatorBuilder: (BuildContext context, int i) =>
                      home.eventsCategory![i].subEventCategoryDtos!.isEmpty
                          ? Container()
                          : Divider(
                              thickness: 1.2,
                            ),
                  itemBuilder: (BuildContext context, int i) => home
                          .eventsCategory![i].subEventCategoryDtos!.isEmpty
                      ? Container()
                      : CustomFilterCheckbox(model: home.eventsCategory![i]),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        log('isFree -> $_isFree');
                        log('from -> $_from');
                        log('to -> $_to');
                        log('home cats -> ${home.cats}');
                        home.setCurrentEventEnum(EventEnum.filter);
                        MagicRouter.pop();
                        await home.filterEvent(
                            isFree: _isFree, fromDate: _from, toDate: _to);
                      },
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  kMainColor,
                                  kMainLighterColor,
                                ])),
                        child: Center(
                          child: MainText(
                              text: 'تصفية', font: 15.sp, color: kAccentColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
