import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/subscribed_company_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SubscribedCompanyProvider extends ChangeNotifier {
  static SubscribedCompanyProvider get(context) =>
      Provider.of<SubscribedCompanyProvider>(context);

  static SubscribedCompanyProvider listenFalse(context) =>
      Provider.of<SubscribedCompanyProvider>(context, listen: false);

  //company name search controller
  TextEditingController companyNameController = TextEditingController();

  //notification message
  TextEditingController notificationController = TextEditingController();

  List<SubscribedCompanyModel> allSubscribedCompanies = [];
  NetworkStatus? getCompaniesStatus;

  Future<void> getSubscribedCompanies({
    required String companyName,
    bool retry = false,
  }) async {
    getCompaniesStatus = NetworkStatus.loading;
    if (retry) {
      notifyListeners();
    }

    try {
      Map<String, dynamic> params = {};

      if (companyName == '') {
        params = {};
      } else {
        params = {
          "compancyName": companyName,
        };
      }

      Uri uri = Uri.parse('${base_url}SubscribeToReadyPlan');
      final finalUri = uri.replace(queryParameters: params);

      var response = await http.get(
        finalUri,
        headers: {
          'Accept-Language': 'ar',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        allSubscribedCompanies = jsonResponse
            .map((e) => SubscribedCompanyModel.fromJson(e))
            .toList();

        log('all companies length ${allSubscribedCompanies.length}');

        getCompaniesStatus = NetworkStatus.success;
      } else {
        log('Error get companies > ${response.body}');

        getCompaniesStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get companies ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> sendNotification({
    required String SenderId,
    required String ReceiverId,
    required String Message,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Map<String, dynamic> params = {
        'SenderId': SenderId,
        'ReceiverId': ReceiverId,
        'Message': Message,
      };

      Uri uri = Uri.parse(
        '${base_url}SendNotifications/sender-send-notification',
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

      log(response.statusCode.toString());

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        notificationController.clear();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم ارسال الاشعار بنجاح',
          ),
        ).then(
          (value) => {
            navigated = true,
            MagicRouter.pop(),
          },
        );
        Future.delayed(
          Duration(seconds: 3),
          () async {
            if (!navigated) {
              if (Navigator.canPop(navigatorKey.currentContext!)) {
                Navigator.pop(navigatorKey.currentContext!);
              }
              MagicRouter.pop();
            }
          },
        );
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في ارسال الاشعار',
          ),
        ).then((value) => MagicRouter.pop());
      }
    } catch (e) {
      log('catch send notification ${e.toString}');
      MagicRouter.pop();
    }
  }
}
