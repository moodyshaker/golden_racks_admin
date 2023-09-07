import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/requests_item.dart';
import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class UnSubscribersEmergencyRequestsTechScreen extends StatefulWidget {
  const UnSubscribersEmergencyRequestsTechScreen({Key? key}) : super(key: key);

  @override
  State<UnSubscribersEmergencyRequestsTechScreen> createState() =>
      _UnSubscribersEmergencyRequestsTechScreenState();
}

class _UnSubscribersEmergencyRequestsTechScreenState
    extends State<UnSubscribersEmergencyRequestsTechScreen> {
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
        title1: 'تحديد فني لطلبات الطوارئ لغير المشتركين',
        body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
          itemBuilder: (BuildContext context, int i) => RequestsItem(),
          itemCount: 2,
        ),
      ),
    );
  }
}
