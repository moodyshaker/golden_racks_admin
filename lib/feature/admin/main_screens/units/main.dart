import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/home_item.dart';
import '../../../widgets/main_text.dart';

class OrganizerMain extends StatefulWidget {
  const OrganizerMain({Key? key}) : super(key: key);

  @override
  State<OrganizerMain> createState() => _OrganizerMainState();
}

class _OrganizerMainState extends State<OrganizerMain> {
  @override
  void initState() {
    super.initState();
    // OrganizerAppCubit.listenFalse(context).getOrganizerEventList(OrganizerAppCubit().status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            MainText(
              text: 'القائمة الرئيسية',
              font: 20.sp,
              color: Colors.black,
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                itemBuilder: (BuildContext context, int i) => HomeItem(),
                itemCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
