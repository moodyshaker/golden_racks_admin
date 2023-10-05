import 'dart:async';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/search_tickets_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/units/technician_main.dart';
import 'package:provider/provider.dart';
import '../appStorage/shared_preference.dart';

class TechnicianAppCubit extends ChangeNotifier {
  static TechnicianAppCubit get(context) =>
      Provider.of<TechnicianAppCubit>(context);

  static TechnicianAppCubit listenFalse(context) =>
      Provider.of<TechnicianAppCubit>(context, listen: false);
  int _i = 0;
  Widget _w = TechnicianMain();
  String _title = 'main';

  Preferences _preferences = Preferences.instance;

  int _start = 30;
  bool _wait = false;
  bool _isPhone = false;
  List<int> _interestsList = [];

  void changeCheckbox(int i) {
    _value = i;
    notifyListeners();
  }

  void changeCheckboxStatus(int i) {
    _status = i;
    notifyListeners();
  }

  bool get isPhone => _isPhone;

  int get value => _value;

  List<int> get interestsList => _interestsList;

  void setIsPhone(bool v) {
    _isPhone = v;
  }

  int _index = 0;

  void setIndex(int i) {
    _index = i;
    notifyListeners();
  }

  int get index => _index;

  void setRememberMe(bool v) {}

  format(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0").substring(3, 8);

  Future<void> clearData() async {
    await _preferences.logout();
  }

  int _value = 0;
  int _status = 0;

  int get status => _status;

  void setStatus(int status) {
    _status = status;
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    _wait = true;
    Timer.periodic(onsec, (timer) {
      if (_start == 0) {
        timer.cancel();
        _wait = false;
      } else {
        _start--;
      }
      notifyListeners();
    });
  }

  void changeCurrent(int i) {
    _i = i;
    _getCurrentScreen();
    notifyListeners();
  }

  void _getCurrentScreen() {
    switch (_i) {
      case 0:
        _w = TechnicianMain();

        _title = 'main';
        break;
      case 1:
        _w = SearchTicketWidget();
        break;
      case 2:
        break;
    }
  }

  Widget get w => _w;

  int get i => _i;

  String get title => _title;

  void resendReset(bool init) {
    _start = 30;
    _wait = true;
    notifyListeners();
  }

  bool get wait => _wait;

  int get start => _start;
}
