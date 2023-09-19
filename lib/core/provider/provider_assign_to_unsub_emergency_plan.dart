import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_emergency_admin_screens/unsubscribers_emergency_requests_screen.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AssignToUnsubEmergencyProvider extends ChangeNotifier {
  static AssignToUnsubEmergencyProvider get(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context);

  static AssignToUnsubEmergencyProvider listenFalse(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context, listen: false);

  List<EmergencyPlanSubModel> emergencyUnsubPlans = [];
  NetworkStatus? emergencyUnsubStatus;

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
            .map((data) => EmergencyPlanSubModel.fromJson(data))
            .toList();

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
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم رفض الخطة بنجاح',
          ),
        ).then(
          (value) => MagicRouter.navigateAndPop(
            UnSubscribersEmergencyRequestsAdminScreen(),
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

  Future<void> assignTechForUnsubEmergency({
    required String UserId,
    required String TechnicalId,
    required int VisitWithoutSubscripeId,
    required String VisitDate,
    required bool IsActive,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse(
          '${base_url}AssigningTechnicalForUnSubscribeEmergency/assing-technical-for-unsubscribe-emergency',
        ),
      );
      request.fields['UserId'] = UserId;
      request.fields['TechnicalId'] = TechnicalId;
      request.fields['VisitWithoutSubscripeId'] =
          VisitWithoutSubscripeId.toString();
      request.fields['VisitDate'] = VisitDate;
      request.fields['IsActive'] = IsActive.toString();

      var streamResponse = await request.send();
      Response response = await Response.fromStream(streamResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تخصيص الفني بنجاح',
          ),
        ).then((value) => MagicRouter.pop());
      } else {
        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في تخصيص الفني',
          ),
        );
      }
    } catch (e) {
      log('carch assign emergency unsub > ${e.toString()}');

      MagicRouter.pop();
    }
  }
}
