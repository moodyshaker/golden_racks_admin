import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../appStorage/shared_preference.dart';
import '../dialogs/credential_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../models/event_category_model.dart';
import '../models/event_model.dart';
import '../networkStatus/network_status.dart';
import '../router/router.dart';

class HomeCubit extends ChangeNotifier {
  static HomeCubit get(context) => Provider.of<HomeCubit>(context);

  static HomeCubit listenFalse(context) =>
      Provider.of<HomeCubit>(context, listen: false);
  List<int> cats = [];
  List<EventModel>? _events;
  List<EventCategoryModel>? _eventsCategory;
  Preferences _preferences = Preferences.instance;
  NetworkStatus? _eventStatus;
  NetworkStatus? _eventCategoryStatus;
  TextEditingController searchController = TextEditingController();
  int _value = 0;

  int get value => _value;

  void setCurrentEventEnum(EventEnum v) {
    _eventEnum = v;
    notifyListeners();
  }

  Future<void> getEventList(
      {bool retry = false, String dateStatus = '2', String? typeId}) async {
    try {
      _eventStatus = NetworkStatus.loading;
      if (retry) {
        notifyListeners();
      }
      Response r = await HttpHelper.instance.httpGet(
          'Event/SearchEventList?pageNumber=1&pageSize=20&userId=${_preferences.getUserId}${typeId != null ? '&TypeId=$typeId' : ''}&EventDateType=$dateStatus',
          false);
      log('events list -> ${r.body}');
      log('r.request!.url -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _events = (jsonDecode(r.body) as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        _eventStatus = NetworkStatus.success;
      } else {
        _eventStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> filterEvent(
      {bool retry = false,
      DateTime? fromDate,
      DateTime? toDate,
      required bool isFree}) async {
    try {
      _eventStatus = NetworkStatus.loading;
      if (retry) {
        notifyListeners();
      }
      Response r = await HttpHelper.instance.httpGet(
          'Event/AdvancedSearch?pageNumber=1&pageSize=20&userId=${_preferences.getUserId}${toDate != null ? '&toDate=$toDate' : ''}${fromDate != null ? '&fromDate=$fromDate' : ''}&isFree=$isFree${cats.isNotEmpty ? '&getCategoryId=$cats' : ''}',
          false);
      log('events list -> ${r.body}');
      log('r.request!.url -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _events = (jsonDecode(r.body) as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        cats.clear();
        _eventStatus = NetworkStatus.success;
      } else {
        _eventStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> searchEvent({bool retry = false, String? word}) async {
    try {
      _eventStatus = NetworkStatus.loading;
      if (retry) {
        notifyListeners();
      }
      Response r = await HttpHelper.instance.httpGet(
          'Event/SearchEventList?pageNumber=1&pageSize=20&userId=${_preferences.getUserId}&searchWord=$word',
          false);
      log('events list -> ${r.body}');
      log('events list -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _events = (jsonDecode(r.body) as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        _eventStatus = NetworkStatus.success;
      } else {
        _eventStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  int _v = 1;
  EventEnum _eventEnum = EventEnum.main;

  EventEnum get eventEnum => _eventEnum;

  void setCurrentEvents(int i) {
    _v = i;
    notifyListeners();
  }

  void changeCheckbox(int i) {
    _value = i;
    notifyListeners();
  }

  int get v => _v;

  Future<void> getEventCategory() async {
    try {
      _eventCategoryStatus = NetworkStatus.loading;
      Response r = await HttpHelper.instance.httpGet(
          'EventeCatgories/GetEventCategory?pageSize=20&pageNumber=1', false);
      log('getEventCategory -> ${r.body}');
      log('getEventCategory -> ${r.request!.url}');
      log('getEventCategory -> ${r.statusCode}');
      if (r.statusCode == 200) {
        _eventsCategory = (jsonDecode(r.body) as List)
            .map((e) => EventCategoryModel.fromJson(e))
            .toList();
        _eventCategoryStatus = NetworkStatus.success;
      } else if (r.statusCode == 401) {
        showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => CredentialDialog());
      } else {
        _eventCategoryStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  NetworkStatus? get eventStatus => _eventStatus;

  List<EventModel>? get events => _events;

  List<EventCategoryModel>? get eventsCategory => _eventsCategory;

  NetworkStatus? get eventCategoryStatus => _eventCategoryStatus;
}

enum EventEnum {
  filter,
  search,
  main,
}
