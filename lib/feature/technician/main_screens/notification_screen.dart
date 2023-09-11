import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/widgets/notification_item.dart';
import '../../../../constants.dart';
import '../../widgets/organizerCustomScaffold.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAsset('background2')),
          fit: BoxFit.fill,
        ),
      ),
      child: OrganizerCustomScaffold(
        backgroundColor: Colors.transparent,
        hasAppbar: false,
        isHome: true,
        hasNavBar: false,
        title1: 'الاشعارات',
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => NotificationItem(),
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}
