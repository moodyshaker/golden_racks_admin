import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/agenda_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DailyTasksProvider extends ChangeNotifier {
  static DailyTasksProvider get(context) =>
      Provider.of<DailyTasksProvider>(context);

  static DailyTasksProvider listenFalse(context) =>
      Provider.of<DailyTasksProvider>(context, listen: false);

  List<AgendaModel> allAgendas = [];
  NetworkStatus? agendaStatus;

  List<AgendaModel> allDailyTasks = [];
  NetworkStatus? dailyTasksStatus;

  Future<void> getAllDailyTasks({
    required String technicalId,
    bool retry = false,
  }) async {
    dailyTasksStatus = NetworkStatus.loading;
    if (retry) {
      notifyListeners();
    }

    try {
      Map<String, dynamic> params = {
        'technicalId': technicalId,
      };

      Uri uri = Uri.parse('${base_url}Technicals/get-all-daily-tasks');
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
        List jsonResponse = json.decode(response.body);
        allDailyTasks =
            jsonResponse.map((e) => AgendaModel.fromJson(e)).toList();

        log('all daily tasks > ${allDailyTasks.length}');
        dailyTasksStatus = NetworkStatus.success;
      } else {
        log('error daily tasks > ${response.body}');
        dailyTasksStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get daily tasks > ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> getAllAgendas({
    required String technicalId,
    bool retry = false,
  }) async {
    agendaStatus = NetworkStatus.loading;
    if (retry) {
      notifyListeners();
    }

    try {
      Map<String, dynamic> params = {
        'technicalId': technicalId,
      };

      Uri uri = Uri.parse('${base_url}Technicals/agenda-for-technical');
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
        List jsonResponse = json.decode(response.body);
        allAgendas = jsonResponse.map((e) => AgendaModel.fromJson(e)).toList();

        log('all Agendas > ${allAgendas.length}');
        agendaStatus = NetworkStatus.success;
      } else {
        log('error agenda > ${response.body}');
        agendaStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get Agenda > ${e.toString()}');
    }
    notifyListeners();
  }
}
