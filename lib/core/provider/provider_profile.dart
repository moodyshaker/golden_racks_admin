import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/constants.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/profile_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/units/admin_home_screen.dart';
import 'package:golden_racks_admin/feature/technician/main_screens/units/technician_main.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  static ProfileProvider get(context) => Provider.of<ProfileProvider>(context);

  static ProfileProvider listenFalse(context) =>
      Provider.of<ProfileProvider>(context, listen: false);

  Preferences _preferences = Preferences.instance;

  //edit profile controllers
  TextEditingController profileFullNameController = TextEditingController();
  TextEditingController profileMobileNumberController = TextEditingController();
  TextEditingController profileFixedNumberController = TextEditingController();

  TextEditingController profileCompanyName_ArController =
      TextEditingController();
  TextEditingController profileCompanyName_EnController =
      TextEditingController();
  TextEditingController profileTaxNumberController = TextEditingController();
  TextEditingController profileStreetController = TextEditingController();
  TextEditingController profileBuildingNumberController =
      TextEditingController();
  //not in the end point
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();

  //reset password controllers
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  NetworkStatus? getProfileStatus;
  ProfileModel profileData = ProfileModel();
  File? selectedProfileImage;

  Future<void> getProfileData({
    required String userId,
    bool retry = false,
  }) async {
    getProfileStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }
    try {
      var response = await HttpHelper.instance.httpGet(
        'Account/get-user-info/${userId}',
        false,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        profileData = ProfileModel.fromJson(jsonDecode(response.body));
        if (profileData.image != null) {
          Preferences.instance.setUserImage(profileData.image!);
        }
        getProfileStatus = NetworkStatus.success;
      } else {
        print('error get profile > ${response.body}');
        getProfileStatus = NetworkStatus.error;
      }
    } catch (e) {
      print('catch get profile ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> editProdile({
    required String UserId,
    required String FullName,
    required String MobileNumber,
    required String FixedNumber,
    required String CompanyName_En,
    required String CompanyName_Ar,
    required String TaxNumber,
    File? Image,
    required int CountryId,
    required int CityId,
    required int StateId,
    required String Street,
    required String BuildingNumber,
    required String UserName,
    required String Email,
    required bool sameMobile,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      Response? validateMobile = await validateUserData(
        Mobile: MobileNumber,
        Email: 'Email',
        UserName: 'UserName',
      );

      if (!(validateMobile!.statusCode >= 200 &&
              validateMobile.statusCode < 300) &&
          !sameMobile) {
        MagicRouter.pop();
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (ctx) => ErrorDialog(
            text: '${validateMobile.body.replaceAll('"', '')}',
          ),
        );
      } else {
        var request = MultipartRequest(
          'POST',
          Uri.parse('${base_url}Account/update-user-info'),
        );

        Map<String, String> headers = {
          "Content-type": "multipart/form-data",
          'Accept-Language': 'ar',
          'Accept': 'application/json',
        };

        if (Image != null) {
          request.files.add(
            await http.MultipartFile(
              'Image',
              await Image.readAsBytes().asStream(),
              await Image.lengthSync(),
              filename: await Image.path.split('/').last,
            ),
          );
        }

        request.fields['UserId'] = UserId;
        request.fields['FullName'] = FullName;
        request.fields['MobileNumber'] = MobileNumber;
        request.fields['FixedNumber'] = FixedNumber;
        // request.fields['CompanyName_En'] = CompanyName_En;
        // request.fields['CompanyName_Ar'] = CompanyName_Ar;
        // request.fields['TaxNumber'] = TaxNumber;
        // request.fields['CountryId'] = CountryId.toString();
        // request.fields['CityId'] = CityId.toString();
        // request.fields['StateId'] = StateId.toString();
        // request.fields['Street'] = Street;
        // request.fields['BuildingNumber'] = BuildingNumber;

        // request.fields['UserName'] = UserName;
        // request.fields['Email'] = Email;

        request.headers.addAll(headers);
        var res = await request.send();
        Response response = await Response.fromStream(res);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (FullName.isNotEmpty) {
            _preferences.setUserFullName(FullName);
          }
          if (Image != null) {
            Preferences.instance.setUserImage(jsonDecode(response.body));
          }
          MagicRouter.pop();
          showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (ctx) => InfoDialog(
              content: 'تم تعديل بيانات الحساب بنجاح',
            ),
          ).then((value) => {
                if (isAdmin!)
                  {
                    MagicRouter.navigateAndPopAll(AdminHome()),
                  }
                else
                  {
                    MagicRouter.navigateAndPopAll(TechnicianMain()),
                  }
              });
        } else {
          print('error edit profile ${response.body}');
          MagicRouter.pop();

          showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: true,
            builder: (ctx) => ErrorDialog(
              text: 'خطأ في تعديل الحساب',
            ),
          );
        }
      }
    } catch (e) {
      print('catch edit profile >> ' + e.toString());
    }
  }

  Future<Response?> validateUserData({
    required String Email,
    required String Mobile,
    required String UserName,
  }) async {
    try {
      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Account/validate-user-credentials'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Accept-Language': 'ar',
        'Accept': 'application/json',
      };

      request.fields['Mobile'] = Mobile;
      request.fields['Email'] = '!!@@##%%^^';
      request.fields['UserName'] = '!!@@##%%^^';

      request.headers.addAll(headers);

      var streamResponse = await request.send();

      Response response = await Response.fromStream(streamResponse);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('valid');
      } else {
        print('notValid');
      }
      return response;
    } catch (e) {
      print('catch validate register data ${e.toString()}');
      return null;
    }
  }

  Future<void> resetPassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var response = await HttpHelper.instance.httpPost(
        'Account/ChangePassword',
        body: {
          "userId": "$userId",
          "oldPassword": "$oldPassword",
          "newPassword": "$newPassword",
          "confirmNewPassword": "$confirmNewPassword",
        },
        false,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        MagicRouter.pop();
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmNewPasswordController.clear();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: "تم تغيير كلمة المرور بنجاح",
          ),
        ).then((value) => {
              navigated = true,
              MagicRouter.pop(),
            });

        Future.delayed(
          Duration(seconds: 3),
          () async {
            if (!navigated) {
              if (Navigator.canPop(navigatorKey.currentContext!)) {
                Navigator.pop(navigatorKey.currentContext!);
              }
              MagicRouter.pop();
            }
          },
        );
      } else {
        MagicRouter.pop();
        print(response.body);
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: 'كلمة المرور غير صحيحة',
          ),
        );
      }
    } catch (e) {
      print('Exception ==> ${e.toString()}');
    }
  }

  Future<void> pickImageFromGallary() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage == null) return;
    print(returnedImage.path);

    selectedProfileImage = File(returnedImage.path);
    notifyListeners();
  }
}
