import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import '../../../core/localization/demo_localization.dart';
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
    init();
  }

  void init() async {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => MagicRouter.navigateAndPopAll(
        OrganizerLogin(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    final demo = DemoLocalization.of(context);
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
          )),
    );
  }
}
