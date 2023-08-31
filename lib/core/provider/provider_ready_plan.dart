import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../feature/widgets/loading_dialog.dart';
import '../dialogs/error_dialog.dart';
import '../dialogs/info_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../models/ready_plan_model.dart';
import '../router/router.dart';

class ReadyPlanProvider extends ChangeNotifier {
  static ReadyPlanProvider get(context) =>
      Provider.of<ReadyPlanProvider>(context);

  static ReadyPlanProvider listenFalse(context) =>
      Provider.of<ReadyPlanProvider>(context, listen: false);

  List<String> arabicPlanTypes = [
    'كل الخطط',
    'خطة شهرية',
    'خطة سنوية',
    'خطة نصف سنوية',
    'خطة ربع سنوية',
    'زيارة طوارئ',
  ];

  List<String> englishPlanTypes = [
    'None',
    'Monthly',
    'Annual',
    'HalfAnnual',
    'Quarterly',
    'Emergency',
  ];

  List<ReadyPlanModel> allReadyPlans = [];
  ReadyPlanModel chosenReadyPlan = ReadyPlanModel();
  int chosenPlanDuration = 0;

  void increaseRack() {
    log('id > ' + chosenReadyPlan.id.toString());
    log('num of racks > ' + chosenReadyPlan.numberOfRacks.toString());
    log('plan price > ' + chosenReadyPlan.planPrice.toString());
    chosenReadyPlan.numberOfRacks = chosenReadyPlan.numberOfRacks! + 1;

    chosenReadyPlan.planPrice =
        (chosenReadyPlan.racksUnitPrice! * chosenReadyPlan.numberOfRacks!) +
            chosenReadyPlan.totalCost!;

    log('id > ' + chosenReadyPlan.id.toString());
    log('num of racks > ' + chosenReadyPlan.numberOfRacks.toString());
    log('plan price > ' + chosenReadyPlan.planPrice.toString());

    notifyListeners();
  }

  void decreaseRack() {
    log('id > ' + chosenReadyPlan.id.toString());
    log('num of racks > ' + chosenReadyPlan.numberOfRacks.toString());
    log('plan price > ' + chosenReadyPlan.planPrice.toString());
    chosenReadyPlan.numberOfRacks = chosenReadyPlan.numberOfRacks! - 1;

    chosenReadyPlan.planPrice =
        (chosenReadyPlan.racksUnitPrice! * chosenReadyPlan.numberOfRacks!) +
            chosenReadyPlan.totalCost!;
    log('id > ' + chosenReadyPlan.id.toString());
    log('num of racks > ' + chosenReadyPlan.numberOfRacks.toString());
    log('plan price > ' + chosenReadyPlan.planPrice.toString());

    notifyListeners();
  }

  //ready plan controllers
  TextEditingController NumberOfFixedVisitsController = TextEditingController();
  TextEditingController NumberOEmregencyVisitsController =
      TextEditingController();
  TextEditingController SparePartsNameController = TextEditingController();
  TextEditingController SparePartsPriceController = TextEditingController();
  TextEditingController TotalCostController = TextEditingController();
  TextEditingController SparePartsDescriptionController =
      TextEditingController();
  TextEditingController QuntityInStockController = TextEditingController();
  TextEditingController MadeInController = TextEditingController();
  TextEditingController NumberOfRacksController = TextEditingController();
  TextEditingController RacksUnitPriceController = TextEditingController();

  bool IsSparePartsController = true;
  bool IsActiveController = true;
  int? PlanDurationController;

  Future<void> addReadyPlan({
    required int PlanDuration,
    required int NumberOfFixedVisits,
    required int NumberOEmregencyVisits,
    required bool IsSpareParts,
    required String SparePartsName,
    required double SparePartsPrice,
    required double TotalCost,
    required String SparePartsDescription,
    required int QuntityInStock,
    required String MadeIn,
    required bool IsActive,
    required int NumberOfRacks,
    required double RacksUnitPrice,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}ReadyPlans'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };
      request.fields['PlanDuration'] = PlanDuration.toString();
      request.fields['NumberOfFixedVisits'] = NumberOfFixedVisits.toString();
      request.fields['NumberOEmregencyVisits'] =
          NumberOEmregencyVisits.toString();
      request.fields['IsSpareParts'] = IsSpareParts.toString();
      request.fields['SparePartsName'] = SparePartsName;
      request.fields['SparePartsPrice'] = SparePartsPrice.toString();
      request.fields['TotalCost'] = TotalCost.toString();
      request.fields['SparePartsDescription'] = SparePartsDescription;
      request.fields['QuntityInStock'] = QuntityInStock.toString();
      request.fields['MadeIn'] = MadeIn;
      request.fields['IsActive'] = IsActive.toString();
      request.fields['NumberOfRacks'] = NumberOfRacks.toString();
      request.fields['RacksUnitPrice'] = RacksUnitPrice.toString();
      request.headers.addAll(headers);

      var res = await request.send();

      Response response = await Response.fromStream(res);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم اضافة الخطة بنجاح',
          ),
        );
      } else {
        log('error >> ${response.body}');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ اضافة الخطة',
          ),
        );
      }
    } catch (e) {
      log('catch add ready plan ${e.toString()}');
      MagicRouter.pop();
    }
  }

  Future<void> getReadyPlan({required int planDuration}) async {
    allReadyPlans = [];
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (ctx) => LoadingDialog(),
    );
    try {
      Map<String, dynamic> params = {};

      if (planDuration == 0) {
        params = {};
      } else {
        params = {
          "planDuration": planDuration.toString(),
        };
      }

      Uri uri = Uri.parse('${base_url}ReadyPlans');
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
        print(response.statusCode);
        List jsonResponse = jsonDecode(response.body);
        allReadyPlans =
            jsonResponse.map((e) => ReadyPlanModel.fromJson(e)).toList();

        log('all Ready length ${allReadyPlans.length}');

        MagicRouter.pop();
      } else {
        log('Error get ready plans > ${response.body}');

        MagicRouter.pop();
      }
    } catch (e) {
      log('catch get ready plans > ${e.toString()}');
      MagicRouter.pop();
    }
    notifyListeners();
  }

  Future<void> subscribeToReadyPlan({
    required String UserId,
    required int ReadyPlanId,
    required bool IsFree,
    required int NumberOfRacks,
    required String StartDate,
    required int NumberOfFixedVisits,
    required int NumberOEmregencyVisits,
    required int PaymentMethod,
    required int TransactionId,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}SubscribeToReadyPlan'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };
      request.fields['UserId'] = UserId;
      request.fields['ReadyPlanId'] = ReadyPlanId.toString();
      request.fields['IsFree'] = IsFree.toString();
      request.fields['NumberOfRacks'] = NumberOfRacks.toString();
      request.fields['StartDate'] = StartDate.toString();
      request.fields['NumberOfFixedVisits'] = NumberOfFixedVisits.toString();
      request.fields['NumberOEmregencyVisits'] =
          NumberOEmregencyVisits.toString();
      request.fields['PaymentMethod'] = PaymentMethod.toString();
      request.fields['TransactionId'] = TransactionId.toString();

      request.headers.addAll(headers);

      var res = await request.send();

      Response response = await Response.fromStream(res);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم الاشتراك في الخطة',
          ),
        );
      } else {
        log('erro >> ${response.body}');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في الاشتراك',
          ),
        );
      }
    } catch (e) {
      log('catch subscribe to ready plan ${e.toString()}');
      MagicRouter.pop();
    }
  }
}
