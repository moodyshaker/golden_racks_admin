import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/bloc/technician_app_cubit.dart';
import 'package:golden_racks_admin/feature/widgets/technicianCustomScaffold.dart';

class TechnicianHome extends StatefulWidget {
  const TechnicianHome({Key? key}) : super(key: key);

  @override
  State<TechnicianHome> createState() => _TechnicianHomeState();
}

class _TechnicianHomeState extends State<TechnicianHome> {
  @override
  Widget build(BuildContext context) {
    final TechnicianAppCubit organizer = TechnicianAppCubit.get(context);
    return TechnicianCustomScaffold(
      backgroundColor: Colors.white,
      isHome: true,
      hasAppbar: true,
      title1: 'اهلا وسهلا',
      title2: 'فني ${Preferences.instance.getUserFullName}',
      title3: '',
      pic: 'profile',
      hasNavBar: true,
      body: organizer.w,
    );
  }
}
