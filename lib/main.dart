import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_racks_admin/core/bloc/technician_app_cubit.dart';
import 'package:golden_racks_admin/core/provider/provider_active_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_add_technation.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_sub_emergency_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_sub_ready_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_emergency_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_assign_to_unsub_normal_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_daily_tasks.dart';
import 'package:golden_racks_admin/core/provider/provider_ready_plan.dart';
import 'package:golden_racks_admin/core/provider/provider_subscribed_Company.dart';
import 'package:provider/provider.dart';
import 'core/appStorage/shared_preference.dart';
import 'core/bloc/app_cubit.dart';
import 'core/bloc/auth_cubit.dart';
import 'core/bloc/home_cubit.dart';
import 'core/bloc/language_cubit.dart';
import 'core/bloc/organizer_app_cubit.dart';
import 'core/localization/demo_localization.dart';
import 'core/provider/provider_auth.dart';
import 'core/router/router.dart';
import 'feature/admin/auth_screens/splash.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    log("Handling a background message: ${message.notification!.title}");
    log("Handling a background message: ${message.notification!.body}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await Preferences.instance.initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext ctx, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppCubit()),
          ChangeNotifierProvider(create: (_) => LanguageCubit()),
          ChangeNotifierProvider(create: (_) => AuthCubit()),
          ChangeNotifierProvider(create: (_) => HomeCubit()),
          ChangeNotifierProvider(create: (_) => OrganizerAppCubit()),
          ChangeNotifierProvider(create: (_) => TechnicianAppCubit()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ReadyPlanProvider()),
          ChangeNotifierProvider(create: (_) => AddTechnationProvider()),
          ChangeNotifierProvider(
              create: (_) => AssignToUnsubEmergencyProvider()),
          ChangeNotifierProvider(create: (_) => AssignToUnsubNormalProvider()),
          ChangeNotifierProvider(create: (_) => AssignToSubEmergencyProvider()),
          ChangeNotifierProvider(create: (_) => AssignToSubReadyProvider()),
          ChangeNotifierProvider(create: (_) => ActivePlanProvider()),
          ChangeNotifierProvider(create: (_) => SubscribedCompanyProvider()),
          ChangeNotifierProvider(create: (_) => DailyTasksProvider()),
        ],
        child: Builder(
          builder: (BuildContext c) => MaterialApp(
            title: 'Golden Racks',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],
            localizationsDelegates: [
              DemoLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: LanguageCubit.get(c).locale,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (locale.languageCode == deviceLocale!.languageCode &&
                    locale.countryCode == deviceLocale.countryCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            theme: ThemeData(fontFamily: 'Lato'),
            builder: (context, child) => Directionality(
              child: child!,
              textDirection: LanguageCubit.get(c).locale.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
            home: Splash(),
          ),
        ),
      ),
    );
  }
}
