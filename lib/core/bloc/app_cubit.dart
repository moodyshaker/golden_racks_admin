import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class AppCubit extends ChangeNotifier {
  static AppCubit get(context) => Provider.of<AppCubit>(context);

  static AppCubit listenFalse(context) =>
      Provider.of<AppCubit>(context, listen: false);
  int _i = 0;
  // Widget _w = OrganizerMain();
  String _title = 'main';
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void changeCurrent(int i) {
    _i = i;
    // _getCurrentScreen();
    notifyListeners();
  }

  // void _getCurrentScreen() {
  //   switch (_i) {
  //     case 0:
  //       _w = Main();
  //       _title = 'main';
  //       break;
  //     case 1:
  //       _w = Category();
  //       _title = 'category';
  //       break;
  //     case 2:
  //       _w = Favourites();
  //       _title = 'favourite';
  //       break;
  //     case 3:
  //       _w = Chat();
  //       _title = 'chat';
  //       break;
  //     case 4:
  //       _w = Calendar();
  //       _title = 'calendar';
  //       break;
  //   }
  // }

  // Widget get w => _w;

  int get i => _i;

  String get title => _title;

  showNotification(RemoteNotification? msg) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/app_icon');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.webxy.malqa',
      'Malqa',
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com.webxy.malqa',
      'Malqa',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        40, msg!.title, msg.body, platformChannelSpecifics,
        payload: null);
  }

  // void iOSPermission() async {
  //   await _fcm.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }

  // void showMyNotification(RemoteMessage? m) {
  //   if (Platform.isIOS) {
  //     iOSPermission();
  //   }
  //   FlutterRingtonePlayer.play(
  //       android: AndroidSounds.notification, ios: IosSounds.glass);
  //   showNotification(m!.notification);
  // }

  // void initialFCM(BuildContext context) {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage m) {
  //     showMyNotification(m);
  //   });
  // }

  // void initialOpenedAppFCM(BuildContext context) {
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) {
  //     showMyNotification(m);
  //   });
  // }
}
