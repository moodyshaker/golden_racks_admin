import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/widgets/need_activate_item.dart';

import '../../../../constants.dart';
import '../../../../core/bloc/home_cubit.dart';
import '../../../widgets/organizerCustomScaffold.dart';
import '../widgets/requests_item.dart';
import '../widgets/subscribers_request_item.dart';

class ActivatePlanScreen extends StatefulWidget {
  const ActivatePlanScreen({Key? key}) : super(key: key);

  @override
  State<ActivatePlanScreen> createState() => _ActivatePlanScreenState();
}

class _ActivatePlanScreenState extends State<ActivatePlanScreen> {

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
        hasAppbar:false,
        isHome: true,
        hasNavBar: false,
        title1: 'حسابات في انتظار تفعيل الخطط لها',
        body: Expanded(
          child: ListView.builder(
            padding:
            EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
            itemBuilder: (BuildContext context, int i) => NeedActivateItem(),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
