import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/emergency_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';

class AssignToUnsubEmergencyProvider extends ChangeNotifier {
  static AssignToUnsubEmergencyProvider get(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context);

  static AssignToUnsubEmergencyProvider listenFalse(context) =>
      Provider.of<AssignToUnsubEmergencyProvider>(context, listen: false);

  List<EmergencyPlanUnSubModel> emergencyUnsubPlans = [];

  EmergencyPlanUnSubModel choosedEmergencyUnsubPlan = EmergencyPlanUnSubModel();

  Future<void> getEmergencyUnsubPlan() async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var response = await HttpHelper.instance.httpGet('EmergencyPlans', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        emergencyUnsubPlans = jsonResponse
            .map((data) => EmergencyPlanUnSubModel.fromJson(data))
            .toList();
        log('all emergency  unsub plans length ${emergencyUnsubPlans.length}');
        MagicRouter.pop();
      } else {
        log('error emergency unsub plans => ${response.body}');
        MagicRouter.pop();
      }
    } catch (e) {
      log('catch emergency unsub plans ${e.toString()}');
      MagicRouter.pop();
    }
  }
}
