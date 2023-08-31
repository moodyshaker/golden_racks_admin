import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../feature/admin/main_screens/home.dart';
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

  List<Country> countries = [];

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
        Uri.parse('${base_url}/Account/Register'),
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

      log(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var r = json.decode(response.body);

        _preferences.setRegisterdUserId(r['userId']);

        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تسجيل الحساب بنجاح',
          ),
        ).then((value) => MagicRouter.navigateTo(AddPlanScreen()));
      } else {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في التسجيل',
          ),
        );
      }
    } catch (e) {
      log('catch register >> ' + e.toString());
      MagicRouter.pop();
    }
  }

  Future<void> authGetCountries() async {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (ctx) => LoadingDialog(),
    );

    var response = await HttpHelper.instance.httpGet('Countries', false);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List jsonResponse = jsonDecode(response.body);
      countries = jsonResponse.map((data) => Country.fromJson(data)).toList();
    } else {
      log('error countries => ${response.statusCode}');
    }
    MagicRouter.pop();
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
        _preferences.setUserToken(r['token']);
        _preferences.setUserEmail(r['email']);
        _preferences.setUserId(r['userId']);
        _preferences.setUserFullName(r['name']);

        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تسجيل الدخول بنجاح',
          ),
        ).then(
          (value) => UserRole == 2
              ? MagicRouter.navigateTo(AdminHome())
              : MagicRouter.navigateTo(
                  TechnicianHome(),
                ),
        );
      } else {
        print('Login Failed');
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'خطأ في تسجيل الدخول',
          ),
        );
      }
    } catch (e) {
      log('catch admin login ${e.toString()}');
      MagicRouter.pop();
    }
  }
}
