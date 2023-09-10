import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class AssignToUnsubEmergencyProvider extends ChangeNotifier {
  static AssignToUnsubEmergencyProvider get(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context);

  static AssignToUnsubEmergencyProvider listenFalse(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context, listen: false);

  List<EmergencyPlanUnSubModel> emergencyUnsubPlans = [];
  NetworkStatus? emergencyUnsubStatus;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> getEmergencyUnsubPlans({
    bool retry = false,
  }) async {
    emergencyUnsubStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      var response = await HttpHelper.instance.httpGet('EmergencyPlans', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        emergencyUnsubPlans = jsonResponse
            .map((data) => EmergencyPlanUnSubModel.fromJson(data))
            .toList();

        log('all emergency  unsub plans length ${emergencyUnsubPlans.length}');

        emergencyUnsubStatus = NetworkStatus.success;
      } else {
        log('error emergency unsub plans => ${response.body}');
        emergencyUnsubStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch emergency unsub plans ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> refuseEmergencyUnsubPlan({
    required int id,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var response = await HttpHelper.instance.httpPost(
        'AssigningTechnicalForUnSubscribeEmergency/refuse-emeregency-order-without-subscriber/$id',
        false,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم رفض الخطة بنجاح',
          ),
        );
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في رفض الخطة',
          ),
        );
      }
    } catch (e) {
      log('catch refuse emergency unsub >> ' + e.toString());
      MagicRouter.pop();
    }
  }

  ///////AUDIO PLAYER/////////////

  Future<void> playRecord({
    required String audioPath,
  }) async {
    log(audioPath);
    Source urlSource = UrlSource(audioPath);
    await audioPlayer.play(urlSource);
    notifyListeners();
  }
}
