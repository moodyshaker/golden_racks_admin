import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/models/admin_statistics_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/units/admin_home_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../feature/admin/other_screens/add_plan_screen.dart';
import '../../feature/technician/main_screens/technician_home.dart';
import '../../feature/widgets/loading_dialog.dart';
import '../appStorage/shared_preference.dart';
import '../dialogs/error_dialog.dart';
import '../dialogs/info_dialog.dart';
import '../httpHelper/http_helper.dart';
import '../models/country_model.dart';
import '../router/router.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider get(context) => Provider.of<AuthProvider>(context);

  static AuthProvider listenFalse(context) =>
      Provider.of<AuthProvider>(context, listen: false);

  Preferences _preferences = Preferences.instance;

  //register controllers
  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerfullNameController = TextEditingController();
  TextEditingController registermobileNumberController =
      TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerCompanyNameController = TextEditingController();
  TextEditingController registerCompanybusinessController =
      TextEditingController();

  //login controllers
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  NetworkStatus? countryStatus;
  List<Country> allCountries = [];

  NetworkStatus? statisticsStatus;
  StatisticsModel statisticsModel = StatisticsModel();

  Future<void> authRegister({
    required int countryId,
    required int cityId,
    required int stateId,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );
      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Account/Register'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };

      request.fields['UserName'] = registerUserNameController.text;
      request.fields['Password'] = registerPasswordController.text;
      request.fields['ConfirmPassword'] = registerPasswordController.text;

      request.fields['fullName'] = registerfullNameController.text;
      request.fields['mobileNumber'] = registermobileNumberController.text;
      request.fields['Email'] = registerEmailController.text;
      request.fields['companyName'] = registerCompanyNameController.text;
      request.fields['companyName_En'] = registerCompanyNameController.text;

      request.fields['countryId'] = countryId.toString();
      request.fields['cityId'] = cityId.toString();
      request.fields['stateId'] = stateId.toString();

      request.fields['UserRole'] = 0.toString();

      request.headers.addAll(headers);

      var res = await request.send();

      Response response = await Response.fromStream(res);
      var r = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _preferences.setRegisterdUserId(r['userId']);

        MagicRouter.pop();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تسجيل الحساب بنجاح',
          ),
        ).then(
          (value) => {
            navigated = true,
            MagicRouter.navigateTo(AddPlanScreen()),
          },
        );

        Future.delayed(Duration(seconds: 3), () {
          if (!navigated) {
            if (Navigator.canPop(navigatorKey.currentContext!)) {
              Navigator.pop(navigatorKey.currentContext!);
            }
            MagicRouter.navigateAndPopAll(AddPlanScreen());
          }
        });
      } else {
        MagicRouter.pop();

        String errorString = r['errors']
            .values
            .first
            .toString()
            .replaceAll(RegExp(r'[\[\]]'), '');

        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: '${errorString}',
          ),
        );
      }
    } catch (e) {
      log('catch register >> ' + e.toString());
      MagicRouter.pop();
    }
  }

  Future<void> authLogin({
    required String UserName,
    required String Password,
    required int UserRole,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Account/Login'),
      );

      request.fields['UserName'] = UserName;
      request.fields['Password'] = Password;
      request.fields['UserRole'] = UserRole.toString();
      var streamResponse = await request.send();
      Response response = await Response.fromStream(streamResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Login Success');

        var r = json.decode(response.body);
        _preferences.setUserToken(r['token'] ?? '');
        _preferences.setUserEmail(r['email'] ?? '');
        _preferences.setUserId(r['userId'] ?? '');
        _preferences.setUserFullName(r['name'] ?? '');
        _preferences.setUserImage(r['image'] ?? '');
        _preferences.setUserName(UserName);

        await setDeviceUserToken(
          userid: r['userId'],
          mobielType: Platform.isAndroid ? 'android' : 'ios',
          deviceusertoken: _preferences.getFcmToken,
        );

        MagicRouter.pop();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تسجيل الدخول بنجاح',
          ),
        ).then((value) => UserRole == 2
            ? {
                navigated = true,
                MagicRouter.navigateAndPopAll(AdminHome()),
                isAdmin = true,
                Preferences.instance.setUserStatus('admin'),
              }
            : {
                navigated = true,
                MagicRouter.navigateAndPopAll(TechnicianHome()),
                isAdmin = false,
                Preferences.instance.setUserStatus('tech'),
              });

        Future.delayed(Duration(seconds: 3), () {
          if (!navigated) {
            if (Navigator.canPop(navigatorKey.currentContext!)) {
              Navigator.pop(navigatorKey.currentContext!);
            }

            if (isAdmin!) {
              MagicRouter.navigateAndPopAll(AdminHome());
            } else {
              MagicRouter.navigateAndPopAll(TechnicianHome());
            }
          }
        });
      } else {
        print('Login Failed');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'اسم المستخدم او كلمة المرور غير صحيحة',
          ),
        );
      }
    } catch (e) {
      log('catch admin login ${e.toString()}');
      MagicRouter.pop();
    }
  }

  Future<void> getAllCountries({
    bool retry = false,
  }) async {
    countryStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }
    try {
      var response = await HttpHelper.instance.httpGet('Countries', false);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = jsonDecode(response.body);
        allCountries =
            jsonResponse.map((data) => Country.fromJson(data)).toList();
        print('all countries length > ${allCountries.length}');
        countryStatus = NetworkStatus.success;
      } else {
        log('error countries => ${response.statusCode}');
        countryStatus = NetworkStatus.error;
      }
    } catch (e) {
      print('catch get countries ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> setDeviceUserToken({
    required String userid,
    required String deviceusertoken,
    required String mobielType,
  }) async {
    try {
      var response = await HttpHelper.instance.httpPost(
        'Account/DeviceUserToken/$userid/$deviceusertoken/$mobielType',
        false,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log('device token set successfully');
      } else {
        log('error device token $response.body');
      }
    } catch (e) {
      log('catch device token');
    }
  }

  Future<void> getStatistics({
    bool retry = false,
  }) async {
    statisticsStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }
    try {
      var response = await HttpHelper.instance.httpGet(
        'Statistics/get-all-home-statistic',
        true,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        statisticsModel = StatisticsModel.fromJson(jsonDecode(response.body));
        mainStatistics = statisticsModel;
        statisticsStatus = NetworkStatus.success;
      } else {
        print('error get statistics > ${response.body}');
        statisticsStatus = NetworkStatus.error;
      }
    } catch (e) {
      print('catch get statistics > ${e.toString()}');
      statisticsStatus = NetworkStatus.error;
    }
    notifyListeners();
  }
}
