import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/feature/admin/main_screens/flow_only.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/share_company_data_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../feature/admin/auth_screens/organizer_login.dart';
import '../../feature/admin/main_screens/units/calender_screen.dart';
import '../../feature/admin/main_screens/units/main.dart';
import '../../feature/admin/main_screens/units/tickets_screen.dart';
import '../../feature/widgets/loading_dialog.dart';
import '../appStorage/shared_preference.dart';
import '../dialogs/error_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../models/event_category_model.dart';
import '../models/event_model.dart';
import '../networkStatus/network_status.dart';
import '../router/router.dart';
import 'app_cubit.dart';

class OrganizerAppCubit extends ChangeNotifier {
  static OrganizerAppCubit get(context) =>
      Provider.of<OrganizerAppCubit>(context);

  static OrganizerAppCubit listenFalse(context) =>
      Provider.of<OrganizerAppCubit>(context, listen: false);
  int _i = 0;
  Widget _w = OrganizerMain();
  String _title = 'main';
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPhoneController = TextEditingController();
  TextEditingController regOrgNameController = TextEditingController();
  TextEditingController regZakatNumberController = TextEditingController();
  TextEditingController regRegistryNumberController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regConfirmPasswordController = TextEditingController();
  TextEditingController regVerificationCodeController = TextEditingController();
  TextEditingController regEventNameController = TextEditingController();
  TextEditingController regEventDetailsController = TextEditingController();
  TextEditingController regTicketPriceController = TextEditingController();
  TextEditingController regDayAttendanceController = TextEditingController();
  TextEditingController regStartDateController = TextEditingController();
  TextEditingController regEndDateController = TextEditingController();
  TextEditingController regCountryController = TextEditingController();
  TextEditingController regAddressController = TextEditingController();
  TextEditingController regMailController = TextEditingController();
  TextEditingController regMobileController = TextEditingController();
  TextEditingController regTheTimeController = TextEditingController();

  Preferences _preferences = Preferences.instance;

  int _start = 30;
  bool _wait = false;
  String? _userId;
  String? _confirmOtp;
  bool _isPhone = false;
  bool _rememberMe = false;
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

  void setRememberMe(bool v) {
    _rememberMe = v;
  }

  format(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0").substring(3, 8);

  Future<void> clearData() async {
    await _preferences.logout();
  }

  int get status => _status;

  void setStatus(int status){
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
    log('${_i}');
    log('${_w.runtimeType}');
    _i = i;
    _getCurrentScreen();
    notifyListeners();
  }

  void _getCurrentScreen() {
    switch (_i) {
      case 0:
        _w = OrganizerMain();
        _title = 'main';
        break;
      case 1:
        _w = FlowOnly();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
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

  // Future<void> login() async {
  //   try {
  //     showDialog(
  //         context: navigatorKey.currentContext!,
  //         barrierDismissible: false,
  //         builder: (ctx) => LoadingDialog());
  //     Response r = await HttpHelper.instance
  //         .httpPost('Account/Login-by-email-or-phone', false, body: {
  //       "emailOrPhone": loginEmailController.text,
  //       "password": loginPasswordController.text
  //     });
  //     log('login statusCode -> ${r.statusCode}');
  //     log('login response -> ${r.body}');
  //     log('_rememberMe -> ${_rememberMe}');
  //     if (r.statusCode >= 200 && r.statusCode < 300) {
  //       await _preferences
  //           .setUserToken(json.decode(r.body)['token'].toString());
  //       await _preferences.setUserId(json.decode(r.body)['userId'].toString());
  //       await _preferences
  //           .setUserEmail(json.decode(r.body)['email'].toString());
  //       if (json.decode(r.body)['name'] != null) {
  //         await _preferences
  //             .setUserName(json.decode(r.body)['name'].toString());
  //       }
  //       if (json.decode(r.body)['image'] != null) {
  //         await _preferences
  //             .setUserName(json.decode(r.body)['image'].toString());
  //       }
  //       await _preferences.setUserType('1');
  //       if (_rememberMe) {
  //         await _preferences.setRememberMe(1);
  //       }
  //       loginEmailController.clear();
  //       loginPasswordController.clear();
  //       MagicRouter.pop();
  //       AppCubit.listenFalse(navigatorKey.currentContext!).changeCurrent(0);
  //       MagicRouter.navigateAndPopAll(OrganizerHome());
  //     } else if (r.statusCode == 404) {
  //       MagicRouter.pop();
  //       showDialog(
  //           context: navigatorKey.currentContext!,
  //           barrierDismissible: false,
  //           builder: (ctx) => CredentialDialog());
  //     } else {
  //       MagicRouter.pop();
  //       showDialog(
  //           context: navigatorKey.currentContext!,
  //           barrierDismissible: false,
  //           builder: (ctx) => ErrorDialog(
  //                 text: json.decode(r.body),
  //               ));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> createNewUser({required File? file}) async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Account/OrganizerRegister'),
      );
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };
      // OfficialDocument
      request.files.add(
        MultipartFile(
          'OfficialDocument',
          file!.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );
      log('name -> ${regOrgNameController.text}');
      request.fields['CompanyNameEn'] = regOrgNameController.text;
      request.fields['UserName'] = regOrgNameController.text;
      request.fields['ZakatAuthorityNumber'] = regZakatNumberController.text;
      request.fields['RecordNumber'] = regRegistryNumberController.text;
      request.fields['PhoneNumber'] = regPhoneController.text;
      request.fields['Email'] = regEmailController.text;
      request.fields['Password'] = regPasswordController.text;
      request.fields['ConfirmPassword'] = regConfirmPasswordController.text;
      request.headers.addAll(headers);
      log('request:  ${request.toString()}');
      var res = await request.send();
      Response r = await Response.fromStream(res);
      log('reg response -> ${r.body}');
      log('reg statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        _userId = json.decode(r.body)['organizerId'];
        regPhoneController.clear();
        regOrgNameController.clear();
        regRegistryNumberController.clear();
        regZakatNumberController.clear();
        regEmailController.clear();
        regPasswordController.clear();
        regConfirmPasswordController.clear();
        MagicRouter.pop();
        // MagicRouter.navigateTo(OrganizerOtpVerification());
      } else {
        MagicRouter.pop();
        showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => ErrorDialog(
                  text: r.body.contains('type')
                      ? jsonDecode(r.body)['errors']['Password'][0]
                      : jsonDecode(r.body),
                ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> confirmOtp() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      Response r = await HttpHelper.instance.httpPost(
          'Account/CheckOTP',
          body: {
            "userId": _userId,
            "otp": regVerificationCodeController.text,
          },
          false);
      log('ActiviteUser response -> ${regVerificationCodeController.text}');
      log('ActiviteUser response -> ${r.body}');
      log('ActiviteUser statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        regVerificationCodeController.clear();
        MagicRouter.pop();
        // MagicRouter.navigateAndPopAll(OrganizerInterestsScreen());
        MagicRouter.navigateAndPopAll(OrganizerLogin());
      } else {
        MagicRouter.pop();
        showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => ErrorDialog(
                  text: json.decode(r.body),
                ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<void> emailExist({String? name, String? email}) async {
  //   try {
  //     showDialog(
  //         context: navigatorKey.currentContext!,
  //         barrierDismissible: false,
  //         builder: (ctx) => LoadingDialog());
  //     Response r = await HttpHelper.instance.httpPost(
  //         'Account/check-user-email-exsist?email=${emailController.text}',
  //         false);
  //     log('emailExist response -> ${r.body}');
  //     log('emailExist statusCode -> ${r.statusCode}');
  //     if (r.statusCode == 200) {
  //       MagicRouter.pop();
  //       emailController.clear();
  //       if (json.decode(r.body) == false) {
  //         regEmailController.text = email!;
  //         MagicRouter.navigateAndPop(OrganizerRegistration1());
  //       } else {
  //         loginEmailController.text = email!;
  //       }
  //     } else {
  //       MagicRouter.pop();
  //       showDialog(
  //           context: navigatorKey.currentContext!,
  //           barrierDismissible: false,
  //           builder: (ctx) => ErrorDialog(
  //                 text: json.decode(r.body),
  //               ));
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  List<EventModel>? _events;
  List<EventCategoryModel>? _eventsCategory;
  TextEditingController searchController = TextEditingController();
  NetworkStatus? _organizerEventStatus;

  NetworkStatus? get organizerEventStatus => _organizerEventStatus;

  Future<void> getEventList() async {
    try {
      _organizerEventStatus = NetworkStatus.loading;
      Response r = await HttpHelper.instance.httpGet(
          'Event/GetEventList?pageNumber=1&pageSize=20&userId=${_preferences.getUserId}',
          false);
      log('events list -> ${r.body}');
      log('events list -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _events = (jsonDecode(r.body) as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        _organizerEventStatus = NetworkStatus.success;
      } else {
        _organizerEventStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  NetworkStatus? _organizerProfileStatus;
  NetworkStatus? _organizerEventCategoryStatus;

  Future<void> getOrganizerProfile() async {
    try {
      _organizerProfileStatus = NetworkStatus.loading;
      Response r = await HttpHelper.instance.httpGet(
          'Account/get-organizer-profile-Info?organizerId=${_preferences.getUserId}',
          true);
      log('events list -> ${r.body}');
      log('events list -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _organizerProfileStatus = NetworkStatus.success;
      } else {
        _organizerProfileStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  int _v = 0;
  int _value = 0;
  int _status = 0;

  void setCurrentEvents(int i) {
    _v = i;
    notifyListeners();
  }

  int get v => _v;

  Future<void> getEventCategory() async {
    try {
      _organizerEventCategoryStatus = NetworkStatus.loading;
      Response r = await HttpHelper.instance.httpGet(
          'EventeCatgories/GetEventCategory?pageSize=10&pageNumber=1', false);
      log('getEventCategory -> ${r.body}');
      log('getEventCategory -> ${r.statusCode}');
      if (r.statusCode == 200) {
        _eventsCategory = (jsonDecode(r.body) as List)
            .map((e) => EventCategoryModel.fromJson(e))
            .toList();
        _organizerEventCategoryStatus = NetworkStatus.success;
      } else {
        _organizerEventCategoryStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  List<EventModel>? get events => _events;

  List<EventCategoryModel>? get eventsCategory => _eventsCategory;

  // Future<void> userInterests() async {
  //   try {
  //     showDialog(
  //         context: navigatorKey.currentContext!,
  //         barrierDismissible: false,
  //         builder: (ctx) => LoadingDialog());
  //     Response r = await HttpHelper.instance
  //         .httpPost('Account/OrganizerPrefrences', false, body: {
  //       "organizerId": _userId,
  //       "organizerPrefrencesDtos": [
  //         {
  //           "superInterstId": 0,
  //           "subIntersts": [0],
  //           "description": "string"
  //         }
  //       ]
  //     });
  //     log('userInterests response -> ${r.body}');
  //     log('userInterests statusCode -> ${r.statusCode}');
  //     if (r.statusCode == 200) {
  //       MagicRouter.pop();
  //       MagicRouter.navigateAndPop(OrganizerHome());
  //     } else {
  //       MagicRouter.pop();
  //       showDialog(
  //           context: navigatorKey.currentContext!,
  //           barrierDismissible: false,
  //           builder: (ctx) => ErrorDialog());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<void> getOrganizerEventList(int status) async {
    try {
      _organizerEventStatus = NetworkStatus.loading;
      Response r = await HttpHelper.instance.httpGet(
          'Event/get-event-status-by-orgainzer?pageNumber=1&pageSize=20&userId=${_preferences.getUserId}&status=${status}',
          false);
      log('events list -> ${r.body}');
      log('events list -> ${r.request!.url}');
      log('event list -> h${r.statusCode}');
      if (r.statusCode == 200) {
        _events = (jsonDecode(r.body) as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
        _organizerEventStatus = NetworkStatus.success;
      } else {
        _organizerEventStatus = NetworkStatus.error;
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  NetworkStatus? get organizerProfileStatus => _organizerProfileStatus;

  NetworkStatus? get organizerEventCategoryStatus =>
      _organizerEventCategoryStatus;
}
