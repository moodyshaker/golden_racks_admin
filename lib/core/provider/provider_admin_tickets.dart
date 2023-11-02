import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/admin_tickets_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:provider/provider.dart';

class AdminTicketsProvider extends ChangeNotifier {
  static AdminTicketsProvider get(context) =>
      Provider.of<AdminTicketsProvider>(context);
  static AdminTicketsProvider listenFalse(context) =>
      Provider.of<AdminTicketsProvider>(context, listen: false);

  NetworkStatus? adminTicketsStatus;
  List<AdminTicketsModel> allAdminTickets = [];

  Future<void> getallAdminTickets({
    bool retry = false,
  }) async {
    adminTicketsStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      var response = await HttpHelper.instance.httpGet(
        'CompanyTicket/all-next-assigned-ticket-for-admin',
        false,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = json.decode(response.body);
        allAdminTickets = jsonResponse
            .map((data) => AdminTicketsModel.fromJson(data))
            .toList();

        print('all admin tickets length > ${allAdminTickets.length}');
        adminTicketsStatus = NetworkStatus.success;
      } else {
        print('error get admin tickets => ${response.body}');
        adminTicketsStatus = NetworkStatus.error;
      }
    } catch (e) {
      print('catch get admin tickets > ${e.toString()}');
      adminTicketsStatus = NetworkStatus.error;
    }
    notifyListeners();
  }
}
