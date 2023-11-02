import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/units/admin_home_screen.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

  List<ReadyPlanModel> allReadyPlans = [];
  int chosenPlanDuration = 0;

  void increaseRack({required ReadyPlanModel readyPlan}) {
    readyPlan.numberOfRacks = readyPlan.numberOfRacks! + 1;

    readyPlan.planPrice =
        (readyPlan.racksUnitPrice! * readyPlan.numberOfRacks!);

    log('id > ' + readyPlan.id.toString());
    log('num of racks > ' + readyPlan.numberOfRacks.toString());
    log('plan price > ' + readyPlan.planPrice.toString());

    notifyListeners();
  }

  void decreaseRack({required ReadyPlanModel readyPlan}) {
    if (readyPlan.numberOfRacks! > 0) {
      readyPlan.numberOfRacks = readyPlan.numberOfRacks! - 1;
    }

    readyPlan.planPrice =
        (readyPlan.racksUnitPrice! * readyPlan.numberOfRacks!);
    log('id > ' + readyPlan.id.toString());
    log('num of racks > ' + readyPlan.numberOfRacks.toString());
    log('plan price > ' + readyPlan.planPrice.toString());

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
  TextEditingController NumberOfFreeSparePartQuantityController =
      TextEditingController();

  bool IsSparePartsController = false;
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
    required List<File> SparePartImages,
    required int NumberOfFreeSparePartQuantity,
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
      request.fields['NumberOfRacks'] = NumberOfRacks.toString();
      request.fields['RacksUnitPrice'] = RacksUnitPrice.toString();
      request.fields['IsActive'] = IsActive.toString();
      request.fields['IsSpareParts'] = IsSpareParts.toString();

      // if (IsSpareParts) {
      request.fields['SparePartsName'] = SparePartsName;
      request.fields['SparePartsPrice'] = SparePartsPrice.toString();
      request.fields['TotalCost'] = TotalCost.toString();
      request.fields['SparePartsDescription'] = SparePartsDescription;
      request.fields['QuntityInStock'] = QuntityInStock.toString();
      request.fields['MadeIn'] = MadeIn;
      request.fields['NumberOfFreeSparePartQuantity'] =
          NumberOfFreeSparePartQuantity.toString();

      for (var image in SparePartImages) {
        request.files.add(
          await http.MultipartFile(
            'SparePartImages',
            await image.readAsBytes().asStream(),
            await image.length(),
            filename: image.path.split('/').last,
          ),
        );
        // }
      }

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
        ).then((value) => MagicRouter.navigateTo(AdminHome()));
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

  Future<void> addSingleSparePart({
    required String Name,
    required double SellingPrice,
    required double PurchasingPrice,
    required String Description,
    required int QuantityInStock,
    required String MadeIn,
    required bool IsActive,
    required List<File> SparePartImages,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}SpareParts'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };
      request.fields['Name'] = Name;
      request.fields['SellingPrice'] = SellingPrice.toString();
      request.fields['PurchasingPrice'] = PurchasingPrice.toString();
      request.fields['Description'] = Description;
      request.fields['QuantityInStock'] = QuantityInStock.toString();
      request.fields['MadeIn'] = MadeIn;
      request.fields['IsActive'] = IsActive.toString();

      for (var image in SparePartImages) {
        request.files.add(
          await http.MultipartFile(
            'SparePartImages',
            await image.readAsBytes().asStream(),
            await image.length(),
            filename: image.path.split('/').last,
          ),
        );
      }

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
            content: 'تم اضافة قطعة الغيار بنجاح',
          ),
        ).then((value) => MagicRouter.navigateTo(AdminHome()));
      } else {
        log('error add single spare part >> ${response.body}');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ اضافة قطعة غيار',
          ),
        );
      }
    } catch (e) {
      log('catch add add single spare part > ${e.toString()}');
      MagicRouter.pop();
    }
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
        //activate the plan
        var r = json.decode(response.body);
        int subscribedPlanId = int.parse(r["id"]);

        Uri subscribeUri = Uri.parse(
          '${base_url}ReadyPlans/activation-status-for-ready-plan',
        );
        final subscribeFinalUri = subscribeUri.replace(queryParameters: {
          'id': subscribedPlanId.toString(),
          'isActive': true.toString(),
        });

        await http.post(
          subscribeFinalUri,
          headers: {
            'Accept-Language': 'ar',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

        log(response.body);
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم الاشتراك في الخطة',
          ),
        ).then((value) => MagicRouter.navigateAndPopAll(AdminHome()));
      } else {
        print('erro >> ${response.body}');
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
      print('catch subscribe to ready plan ${e.toString()}');
      MagicRouter.pop();
    }
  }

  Future<File?> pickImageFromGallary() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return returnedImage != null ? File(returnedImage.path) : null;
  }
}
