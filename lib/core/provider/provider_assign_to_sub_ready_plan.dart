import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/today_appointment_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';

class AssignToSubReadyProvider extends ChangeNotifier {
  static AssignToSubReadyProvider get(context) =>
      Provider.of<AssignToSubReadyProvider>(context);

  static AssignToSubReadyProvider listenFalse(context) =>
      Provider.of<AssignToSubReadyProvider>(context, listen: false);

  List<TodayAppointmentModel> todayAppointments = [];
  NetworkStatus? readySubStatus;

  Future<void> getReadySubPlans({
    bool retry = false,
  }) async {
    readySubStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      var response = await HttpHelper.instance.httpGet(
        'AssigningTechnicalForSubscribeReady/get-all-appointment-from-system-today',
        false,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        todayAppointments = jsonResponse
            .map((data) => TodayAppointmentModel.fromJson(data))
            .toList();

        readySubStatus = NetworkStatus.success;
      } else {
        log('error ready sub plans => ${response.body}');
        readySubStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch ready sub plans ${e.toString()}');
      readySubStatus = NetworkStatus.error;
    }
    notifyListeners();
  }

  Future<void> assignTechForSubReady({
    required String UserId,
    required String TechnicalId,
    required int subsribeToReadyPlanId,
    required String VisitDate,
    required bool IsActive,
    required int readyPlanId,
    required String ticketNumber,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var response = await HttpHelper.instance.httpPost(
        'AssigningTechnicalForSubscribeReady/assign-technical-for-subscribe-ready',
        false,
        body: {
          'UserId': UserId,
          'TechnicalId': TechnicalId,
          'VisitDate': VisitDate,
          'IsActive': IsActive,
          'subsribeToReadyPlanId': subsribeToReadyPlanId,
          'readyPlanId': readyPlanId,
          'ticketNumber': ticketNumber,
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
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
            await getReadySubPlans();
            MagicRouter.pop();
            MagicRouter.pop();
          },
        );
        ;
      } else {
        log('error assign ready sub> ${response.body}');
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
      log('catch assign ready sub > ${e.toString()}');

      MagicRouter.pop();
    }
  }
}
