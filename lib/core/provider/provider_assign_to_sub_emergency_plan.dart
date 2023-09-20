import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_sub_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AssignToSubEmergencyProvider extends ChangeNotifier {
  static AssignToSubEmergencyProvider get(context) =>
      Provider.of<AssignToSubEmergencyProvider>(context);

  static AssignToSubEmergencyProvider listenFalse(context) =>
      Provider.of<AssignToSubEmergencyProvider>(context, listen: false);

  List<EmergencyPlanSubModel> emergencySubPlans = [];
  NetworkStatus? emergencySubStatus;

  Future<void> getEmergencySubPlans({
    bool retry = false,
  }) async {
    emergencySubStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      var response =
          await HttpHelper.instance.httpGet('EmergencyPlanSubscribers', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        emergencySubPlans = jsonResponse
            .map((data) => EmergencyPlanSubModel.fromJson(data))
            .toList();

        emergencySubStatus = NetworkStatus.success;
      } else {
        log('error emergency sub plans => ${response.body}');
        emergencySubStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch emergency sub plans ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> assignTechForSubEmergency({
    required String UserId,
    required String TechnicalId,
    required int VisitWithSubscribeId,
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
          '${base_url}AssigningTechnicalForSubscribeEmergency/assign-technical-for-subscribe-emergency',
        ),
      );

      request.fields['UserId'] = UserId;
      request.fields['TechnicalId'] = TechnicalId;
      request.fields['VisitWithSubscribeId'] = VisitWithSubscribeId.toString();
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
        ).then(
          (value) async {
            showDialog(
              context: navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (ctx) => LoadingDialog(),
            );
            await getEmergencySubPlans();
            MagicRouter.pop();
            MagicRouter.pop();
          },
        );
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
      log('carch assign emergency sub > ${e.toString()}');

      MagicRouter.pop();
    }
  }
}
