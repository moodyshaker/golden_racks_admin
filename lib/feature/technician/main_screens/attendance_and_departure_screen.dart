import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/feature/widgets/main_text.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class AttendanceAndDepartureScreen extends StatefulWidget {
  const AttendanceAndDepartureScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceAndDepartureScreen> createState() =>
      _AttendanceAndDepartureScreenState();
}

class _AttendanceAndDepartureScreenState
    extends State<AttendanceAndDepartureScreen> {
  @override
  void initState() {
    super.initState();
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
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
        title1: 'تسجيل الحضور والانصراف للمهمة',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                            color: lightBlueColor,
                          ),
                          child: Center(
                            child: MainText(
                              text: 'تسجيل الحضور',
                              color: Colors.white,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: MainText(
                              text: 'تسجيل الانصراف',
                              color: Colors.white,
                              font: 15.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
