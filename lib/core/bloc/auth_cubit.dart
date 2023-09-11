import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/bloc/app_cubit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../feature/widgets/loading_dialog.dart';
import '../appStorage/shared_preference.dart';
import '../dialogs/error_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../router/router.dart';

class AuthCubit extends ChangeNotifier {
  static AuthCubit get(context) => Provider.of<AuthCubit>(context);

  static AuthCubit listenFalse(context) =>
      Provider.of<AuthCubit>(context, listen: false);

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController regEmailController = TextEditingController();
  TextEditingController regPhoneController = TextEditingController();
  TextEditingController regBirthDateController = TextEditingController();
  TextEditingController regGenderController = TextEditingController();
  TextEditingController regWorkController = TextEditingController();
  TextEditingController regStudiesController = TextEditingController();
  TextEditingController regPasswordController = TextEditingController();
  TextEditingController regConfirmPasswordController = TextEditingController();
  TextEditingController regVerificationCodeController = TextEditingController();
  TextEditingController regNameController = TextEditingController();
  Preferences _preferences = Preferences.instance;

  int _start = 30;
  bool _wait = false;
  String? _userId;
  bool _isPhone = false;
  bool _rememberMe = false;
  List<int> _interestsList = [];

  bool get isPhone => _isPhone;

  List<int> get interestsList => _interestsList;

  void setIsPhone(bool v) {
    _isPhone = v;
  }

  void setRememberMe(bool v) {
    _rememberMe = v;
  }

  format(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0").substring(3, 8);

  Future<void> clearData() async {
    await _preferences.logout();
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

  void resendReset(bool init) {
    _start = 30;
    _wait = true;
    notifyListeners();
  }

  bool get wait => _wait;

  int get start => _start;

  Future<void> login() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      Response r = await HttpHelper.instance
          .httpPost('Account/Login-by-email-or-phone', false, body: {
        "emailOrPhone": loginEmailController.text,
        "password": loginPasswordController.text
      });
      log('login statusCode -> ${r.statusCode}');
      log('login response -> ${r.body}');
      log('_rememberMe -> ${_rememberMe}');
      if (r.statusCode >= 200 && r.statusCode < 300) {
        await _preferences
            .setUserToken(json.decode(r.body)['token'].toString());
        await _preferences.setUserId(json.decode(r.body)['userId'].toString());
        await _preferences
            .setUserEmail(json.decode(r.body)['email'].toString());
        if (json.decode(r.body)['name'] != null) {
          await _preferences
              .setUserName(json.decode(r.body)['name'].toString());
        }
        if (json.decode(r.body)['image'] != null) {
          await _preferences
              .setUserName(json.decode(r.body)['image'].toString());
        }
        await _preferences.setUserType('0');
        if (_rememberMe) {
          _preferences.setRememberMe(1);
        }
        loginEmailController.clear();
        loginPasswordController.clear();
        MagicRouter.pop();
        AppCubit.listenFalse(navigatorKey.currentContext!).changeCurrent(0);
        // MagicRouter.navigateAndPopAll(Home());
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

  Future<void> createNewUser() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Account/Register'),
      );
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };
      request.fields['FullName'] = regNameController.text;
      request.fields['PhoneNumber'] = regPhoneController.text;
      request.fields['Email'] = regEmailController.text;
      request.fields['BirthDate'] = regBirthDateController.text;
      request.fields['Gender'] = regGenderController.text;
      request.fields['CurrenWork'] = regWorkController.text;
      request.fields['YourStudents'] = regStudiesController.text;
      request.fields['Password'] = regPasswordController.text;
      request.fields['ConfirmPassword'] = regConfirmPasswordController.text;
      request.headers.addAll(headers);
      log('request:  ${request.toString()}');
      var res = await request.send();
      Response r = await Response.fromStream(res);
      log('reg response -> ${r.body}');
      log('reg statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        _userId = json.decode(r.body)['userId'];
        regPhoneController.clear();
        regNameController.clear();
        regEmailController.clear();
        regPasswordController.clear();
        regConfirmPasswordController.clear();
        regStudiesController.clear();
        regBirthDateController.clear();
        regWorkController.clear();
        regGenderController.clear();
        MagicRouter.pop();
        // MagicRouter.navigateTo(InterestsScreen());
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
      log('ActiviteUser response -> ${_preferences.getUserId}');
      log('ActiviteUser response -> ${r.body}');
      log('ActiviteUser statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        regVerificationCodeController.clear();
        MagicRouter.pop();
        // MagicRouter.navigateAndPopAll(Login());
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

  Future<void> emailExist({String? name, String? email}) async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      Response r = await HttpHelper.instance.httpPost(
          'Account/check-user-email-exsist?email=${emailController.text}',
          false);
      log('emailExist response -> ${r.body}');
      log('emailExist statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        MagicRouter.pop();
        emailController.clear();
        if (json.decode(r.body) == false) {
          regEmailController.text = email!;
          regNameController.text = name!;
          // MagicRouter.navigateAndPop(Registration());
        } else {
          loginEmailController.text = email!;
        }
      } else {
        MagicRouter.pop();
        showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => ErrorDialog(text: json.decode(r.body)));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> userInterests() async {
    try {
      showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => LoadingDialog());
      Response r = await HttpHelper.instance.httpPost(
          'Account/user-interests', false,
          body: {"userId": _userId, "userPrefrences": _interestsList});
      log('userInterests response -> ${r.body}');
      log('userInterests statusCode -> ${r.statusCode}');
      if (r.statusCode == 200) {
        MagicRouter.pop();
        // MagicRouter.navigateAndPop(OtpVerification());
      } else {
        MagicRouter.pop();
        showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => ErrorDialog());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
