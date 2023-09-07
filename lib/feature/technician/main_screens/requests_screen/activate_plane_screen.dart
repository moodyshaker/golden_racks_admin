import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';

import '../../../../constants.dart';
import '../../../widgets/organizerCustomScaffold.dart';

class ActivatePlanTechScreen extends StatefulWidget {
  const ActivatePlanTechScreen({Key? key}) : super(key: key);

  @override
  State<ActivatePlanTechScreen> createState() => _ActivatePlanTechScreenState();
}

class _ActivatePlanTechScreenState extends State<ActivatePlanTechScreen> {
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
        title1: 'حسابات في انتظار تفعيل الخطط لها',
        body: Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => NeedActivateItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
