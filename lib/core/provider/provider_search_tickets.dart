import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/models/table_object_model.dart';
import 'package:golden_racks_admin/core/models/ticket_invoice_details_model.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/search_tickets_screen.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/search_ticket_model.dart';
import 'package:golden_racks_admin/core/models/spare_part_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';

class SearchTicketProvider extends ChangeNotifier {
  static SearchTicketProvider get(context) =>
      Provider.of<SearchTicketProvider>(context);

  static SearchTicketProvider listenFalse(context) =>
      Provider.of<SearchTicketProvider>(context, listen: false);

  ////// search tickets//////
  List<SearchTicketModel> allSearchTickets = [];
  NetworkStatus? searchTicketStatus;

  List<SparePartModel> allSpareParts = [];
  NetworkStatus? sparePartStatus;
  TextEditingController sparePartSearchController = TextEditingController();

  Future<void> getSearchTickets({
    required String technicalId,
    required int ticketType,
    bool retry = false,
  }) async {
    searchTicketStatus = NetworkStatus.loading;
    if (retry) {
      notifyListeners();
    }

    try {
      Map<String, dynamic> params = {
        'technicalId': technicalId,
        'technicalTicketStatus': ticketType.toString(),
      };

      Uri uri =
          Uri.parse('${base_url}Technicals/advanced-search-for-technical');
      final finalUri = uri.replace(queryParameters: params);

      var response = await http.get(
        finalUri,
        headers: {
          'Accept-Language': 'ar',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Preferences.instance.getUserToken}'
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = json.decode(response.body);
        allSearchTickets =
            jsonResponse.map((e) => SearchTicketModel.fromJson(e)).toList();

        log('all search tickets > ${allSearchTickets.length}');
        searchTicketStatus = NetworkStatus.success;
      } else {
        log('error search tickets > ${response.body}');
        searchTicketStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get search tickets > ${e.toString()}');
    }
    notifyListeners();
  }

  /////// Technical Report ////////
  TextEditingController addTechnicalReportController = TextEditingController();

  Future<void> addTechnicalReport({
    required String TechnicalId,
    required String CompanyId,
    required String TicketNumber,
    required int SubscriptionId,
    required String ReportMessage,
    required int dailyTaskReturnTypeId,
    required String dailyTaskReturnTypeName,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Technicals/write-technical-report'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Preferences.instance.getUserToken}'
      };
      request.fields['TechnicalId'] = TechnicalId;
      request.fields['CompanyId'] = CompanyId;
      request.fields['TicketNumber'] = TicketNumber;
      request.fields['SubscriptionId'] = SubscriptionId.toString();
      request.fields['ReportMessage'] = ReportMessage;
      request.fields['dailyTaskReturnTypeId'] =
          dailyTaskReturnTypeId.toString();
      request.fields['dailyTaskReturnTypeName'] = dailyTaskReturnTypeName;

      request.headers.addAll(headers);
      var res = await request.send();

      Response response = await Response.fromStream(res);

      print(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم حفظ التقرير بنجاح',
          ),
        ).then((value) => {
              addTechnicalReportController.clear(),
              MagicRouter.pop(),
            });
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في حفظ التقرير',
          ),
        );
      }
    } catch (e) {
      print('catch add thechnical report ${e.toString()}');
      MagicRouter.pop();
    }
  }

  //////// send Alert to company ////////

  TextEditingController sendAlertToCompanyController = TextEditingController();

  Future<void> sendAlertToCompany({
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

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم ارسال التنبيه بنجاح',
          ),
        ).then((value) => MagicRouter.pop());
        sendAlertToCompanyController.clear();
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في ارسال التنبيه',
          ),
        );
      }
    } catch (e) {
      log('catch send notification ${e.toString}');
      MagicRouter.pop();
    }
  }

  ////////Attendance and Departure /////////

  Future<void> technicalAttendence({
    required String TechnicalId,
    required String CompanyId,
    required String TicketNumber,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Map<String, dynamic> params = {
        'TechnicalId': TechnicalId,
        'CompanyId': CompanyId,
        'TicketNumber': TicketNumber,
      };

      Uri uri = Uri.parse(
        '${base_url}TechnicalAttendance/checkIn-attendance',
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
            content: 'تم تسجيل الحضور بنجاح',
          ),
        ).then((value) => MagicRouter.pop());
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في تسجيل الحضور',
          ),
        );
      }
    } catch (e) {
      log('catch check in attendence ${e.toString}');
      MagicRouter.pop();
    }
  }

  Future<void> technicalDeparture({
    required String TechnicalId,
    required String CompanyId,
    required String TicketNumber,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Map<String, dynamic> params = {
        'TechnicalId': TechnicalId,
        'CompanyId': CompanyId,
        'TicketNumber': TicketNumber,
      };

      Uri uri = Uri.parse(
        '${base_url}TechnicalAttendance/checkOut-attendance',
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
            content: 'تم تسجيل الانصراف بنجاح',
          ),
        ).then((value) => MagicRouter.navigateAndPopAll(SearchTicketsScreen()));
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'يجب تسجيل الحضور اولا',
          ),
        );
      }
    } catch (e) {
      log('catch check in Departure ${e.toString}');
      MagicRouter.pop();
    }
  }

  /////// invoice section ///////
  Future<void> getSpareParts({
    required String name,
    bool retry = false,
  }) async {
    sparePartStatus = NetworkStatus.loading;
    if (retry) {
      notifyListeners();
    }
    try {
      Map<String, dynamic> params = {};

      if (name == '') {
        params = {};
      } else {
        params = {
          "name": name,
        };
      }

      Uri uri = Uri.parse('${base_url}SpareParts');
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
        allSpareParts =
            jsonResponse.map((e) => SparePartModel.fromJson(e)).toList();

        log('all spare parts length ${allSpareParts.length}');

        sparePartStatus = NetworkStatus.success;
      } else {
        log('Error get spare parts > ${response.body}');

        sparePartStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get spare parts > ${e.toString()}');
    }
    notifyListeners();
  }

  List<TableObject> tableList = [];

  TableRow buildRow({
    required List<Widget> cells,
    Color? cellColor,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        color: cellColor ?? gray_20,
      ),
      children: cells.map(
        (e) {
          return Container(
            padding: EdgeInsets.all(10),
            child: e,
          );
        },
      ).toList(),
    );
  }

  void addTableToList({required TableObject data}) {
    tableList.add(data);
    notifyListeners();
  }

  int totalQuantity = 0;
  double totalPrice = 0;
  TextEditingController invoiceNotesController = TextEditingController();

  Future<void> addTicketInvoice({
    required String ticketNumber,
    required String technicalId,
    required String companyId,
    required int dailyTaskReturnTypeId,
    required String dailyTaskReturnTypeName,
    required String problemName,
    required String readyPlanName,
    required String note,
    required List<AddTicketInvoiceDetailsRquestDtos>
        addTicketInvoiceDetailsRquestDtos,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var body = {
        "ticketNumber": ticketNumber,
        "technicalId": technicalId,
        "companyId": companyId,
        "dailyTaskReturnTypeId": dailyTaskReturnTypeId,
        "dailyTaskReturnTypeName": dailyTaskReturnTypeName,
        "problemName": problemName,
        "readyPlanName": readyPlanName,
        "note": note,
        "addTicketInvoiceDetailsRquestDtos":
            addTicketInvoiceDetailsRquestDtos.map((e) => e.toJson()).toList(),
      };
      var response = await HttpHelper.instance.httpPost(
        'TicketInvoice',
        true,
        body: body,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();

        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم حفظ الفاتورة بنجاح',
          ),
        ).then((value) => {
              tableList.clear(),
              invoiceNotesController.clear(),
              totalPrice = 0,
              totalQuantity = 0,
              MagicRouter.pop(),
            });
      } else {
        print('error add ticket invoice>> ${response.body}');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطا\n${json.decode(response.body)['message']}',
          ),
        );
      }
    } catch (e) {
      print('catch add ticket invoice ${e.toString()}');
      MagicRouter.pop();
    }
  }
}
