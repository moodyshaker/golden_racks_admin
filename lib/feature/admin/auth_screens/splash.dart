import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/notifications/firebase.dart';
import 'package:golden_racks_admin/core/provider/provider_auth.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/units/admin_home_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/units/technician_main.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../constants.dart';
import '../../../core/router/router.dart';
import '../../widgets/customScaffold.dart';
import 'organizer_login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    FirebaseNotifications.getFCM();
    init();
  }

  void init() async {
    bool isExpired;
    Future.delayed(
      const Duration(milliseconds: 1000),
      () async => {
        if (Preferences.instance.getUserToken.isEmpty)
          {
            MagicRouter.navigateAndPopAll(OrganizerLogin()),
          }
        else
          {
            isExpired = JwtDecoder.isExpired(Preferences.instance.getUserToken),
            if (isExpired)
              {
                MagicRouter.navigateAndPopAll(OrganizerLogin()),
              }
            else
              {
                await AuthProvider.listenFalse(context).setDeviceUserToken(
                  userid: Preferences.instance.getUserId,
                  mobielType: Platform.isAndroid ? 'android' : 'ios',
                  deviceusertoken: Preferences.instance.getFcmToken,
                ),
                if (Preferences.instance.getUserStatus == 'admin')
                  {
                    MagicRouter.navigateAndPopAll(AdminHome()),
                    isAdmin = true,
                  }
                else if (Preferences.instance.getUserStatus == 'tech')
                  {
                    MagicRouter.navigateAndPopAll(TechnicianMain()),
                    isAdmin = false,
                  }
                else
                  {
                    MagicRouter.navigateAndPopAll(OrganizerLogin()),
                  }
              }
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            getAsset('background'),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: CustomScaffold(
        backgroundColor: Colors.transparent,
        isHome: false,
        hasAppbar: false,
        hasNavBar: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(getAsset('logo')),
          ],
        ),
      ),
    );
  }
}
