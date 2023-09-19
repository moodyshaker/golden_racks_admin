import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/un_active_plan_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/active_plan_screens/activate_plane_admin_screen.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ActivePlanProvider extends ChangeNotifier {
  static ActivePlanProvider get(context) =>
      Provider.of<ActivePlanProvider>(context);

  static ActivePlanProvider listenFalse(context) =>
      Provider.of<ActivePlanProvider>(context, listen: false);

  List<UnActivePlanModel> allUnActivePlans = [];
  NetworkStatus? unActivePlanStatus;

  Future<void> getAllUnActivePlans({
    bool retry = false,
  }) async {
    try {
      unActivePlanStatus = NetworkStatus.loading;
      if (retry) {
        notifyListeners();
      }

      var response = await HttpHelper.instance
          .httpGet('ReadyPlans/get-all-unActive-plan', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        allUnActivePlans = jsonResponse
            .map((data) => UnActivePlanModel.fromJson(data))
            .toList();

        unActivePlanStatus = NetworkStatus.success;
      } else {
        log('Error get unActive plans > ${response.body}');
        unActivePlanStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get unActive plan');
      unActivePlanStatus = NetworkStatus.success;
    }
    notifyListeners();
  }

  Future<void> activateUnActivePlan({required int planId}) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Map<String, dynamic> params = {
        'id': planId.toString(),
        'isActive': true.toString(),
      };

      Uri uri = Uri.parse(
        '${base_url}ReadyPlans/activation-status-for-ready-plan',
      );
      final finalUri = uri.replace(queryParameters: params);

      var header = {
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var response = await http.post(
        finalUri,
        headers: header,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تفعيل الخطة بنجاح',
          ),
        ).then(
          (value) => MagicRouter.navigateAndPop(ActivatePlanAdminScreen()),
        );
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في تفعيل الخطة',
          ),
        );
      }
    } catch (e) {
      log('catch activate activePlan >> ' + e.toString());
      MagicRouter.pop();
    }
  }

  Future<void> refuseUnActivePlan({required int planId}) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Map<String, dynamic> params = {
        'id': planId.toString(),
        'isActive': false.toString(),
      };

      Uri uri = Uri.parse(
        '${base_url}ReadyPlans/activation-status-for-ready-plan',
      );
      final finalUri = uri.replace(queryParameters: params);

      var header = {
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      var response = await http.post(
        finalUri,
        headers: header,
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
          (value) => MagicRouter.navigateAndPop(ActivatePlanAdminScreen()),
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
      log('catch refuse activePlan >> ' + e.toString());
      MagicRouter.pop();
    }
  }
}
