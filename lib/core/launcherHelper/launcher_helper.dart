// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      null;
    // showDefaultErrorMessage();
  }

  static Future<void> launchPhone(String phone) async {
    // Permission.phone.request();
    final url = 'tel:$phone';
    if (await canLaunch(url)) await launch(url);
  }

  static Future<void> launchEmail(String? email) async {
    // Permission.phone.request();
    final url = "mailto:$email";
    if (await canLaunch(url)) await launch(url);
  }

  static Future<void> launchWhatsApp({
    @required String? phone,
    @required String? message,
  }) async {
    String url() {
      if (Platform.isAndroid)
        return "https://wa.me/$phone/?text=${Uri.parse(message!)}";
      else
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message!)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    }
  }
}
