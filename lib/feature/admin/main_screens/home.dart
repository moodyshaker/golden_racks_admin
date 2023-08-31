import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/bloc/organizer_app_cubit.dart';
import 'package:golden_racks_admin/feature/widgets/organizerCustomScaffold.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    final OrganizerAppCubit organizer = OrganizerAppCubit.get(context);
    return OrganizerCustomScaffold(
      backgroundColor: Colors.white,
      isHome: true,
      hasAppbar: true,
      title1: 'اهلا وسهلا',
      title2: 'Administrator',
      title3: '',
      pic: 'profile',
      hasNavBar: true,
      body: organizer.w,
    );
  }
}
