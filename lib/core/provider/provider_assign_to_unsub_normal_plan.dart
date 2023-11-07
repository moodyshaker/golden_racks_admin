import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/normal_plan_unsub_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/unsubscribe_normal_admin_screens/unsubscribers_normal_requests_screen.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AssignToUnsubNormalProvider extends ChangeNotifier {
  static AssignToUnsubNormalProvider get(context) =>
      Provider.of<AssignToUnsubNormalProvider>(context);

  static AssignToUnsubNormalProvider listenFalse(context) =>
      Provider.of<AssignToUnsubNormalProvider>(context, listen: false);

  List<NormalPlanUnSubModel> normalUnsubPlans = [];
  NetworkStatus? normalUnsubStatus;

  Future<void> getNormalUnsubPlans({
    bool retry = false,
  }) async {
    normalUnsubStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      var response = await HttpHelper.instance.httpGet('NormalPlans', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        normalUnsubPlans = jsonResponse
            .map((data) => NormalPlanUnSubModel.fromJson(data))
            .toList();

        normalUnsubStatus = NetworkStatus.success;
      } else {
        log('error normal unsub plans => ${response.body}');
        normalUnsubStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch normal unsub plans ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> refuseNormalUnsubPlan({
    required int id,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var response = await HttpHelper.instance.httpPost(
        'AssigningTechnicalForUnSubscribeNormal/refuse-normal-order-without-subscriber/$id',
        false,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم رفض الخطة بنجاح',
          ),
        ).then((value) => {
              navigated = true,
              MagicRouter.navigateAndPop(
                UnSubscribersNormalRequestsAdminScreen(),
              ),
            });

        Future.delayed(
          Duration(seconds: 3),
          () {
            if (!navigated) {
              if (Navigator.canPop(navigatorKey.currentContext!)) {
                Navigator.pop(navigatorKey.currentContext!);
              }
              MagicRouter.navigateAndPop(
                UnSubscribersNormalRequestsAdminScreen(),
              );
            }
          },
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
      log('catch refuse normal unsub >> ' + e.toString());
      MagicRouter.pop();
    }
  }

  Future<void> assignTechForUnsubNormal({
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
          '${base_url}AssigningTechnicalForUnSubscribeNormal/assing-technical-for-unsubscribe-normal',
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
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تخصيص الفني بنجاح',
          ),
        ).then(
          (value) async {
            navigated = true;
            showDialog(
              context: navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (ctx) => LoadingDialog(),
            );
            await getNormalUnsubPlans();
            MagicRouter.pop();
            MagicRouter.pop();
          },
        );
        Future.delayed(
          Duration(seconds: 3),
          () async {
            if (!navigated) {
              if (Navigator.canPop(navigatorKey.currentContext!)) {
                Navigator.pop(navigatorKey.currentContext!);
              }
              await getNormalUnsubPlans();
              MagicRouter.pop();
            }
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
      log('catch assign normal unsub > ${e.toString()}');

      MagicRouter.pop();
    }
  }
}
