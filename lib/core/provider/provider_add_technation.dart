import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golden_racks_admin/core/appStorage/shared_preference.dart';
import 'package:golden_racks_admin/core/dialogs/error_dialog.dart';
import 'package:golden_racks_admin/core/dialogs/info_dialog.dart';
import 'package:golden_racks_admin/core/httpHelper/http_helper.dart';
import 'package:golden_racks_admin/core/models/technical_model.dart';
import 'package:golden_racks_admin/core/networkStatus/network_status.dart';
import 'package:golden_racks_admin/core/router/router.dart';
import 'package:golden_racks_admin/feature/admin/other_screens/technician_view_screen.dart';
import 'package:golden_racks_admin/feature/widgets/loading_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddTechnationProvider extends ChangeNotifier {
  static AddTechnationProvider get(context) =>
      Provider.of<AddTechnationProvider>(context);

  static AddTechnationProvider listenFalse(context) =>
      Provider.of<AddTechnationProvider>(context, listen: false);

  List<Technical> allTechnicals = [];
  File? selectedTechnicalImage;

  //add technical controllers
  TextEditingController addTechfullNameController = TextEditingController();
  TextEditingController addTechPasswordController = TextEditingController();
  TextEditingController addTechmobileNumberController = TextEditingController();
  TextEditingController addTechEmailController = TextEditingController();
  TextEditingController addTechUserNameController = TextEditingController();

  //view technicals controllers
  TextEditingController searchTechController = TextEditingController();

  NetworkStatus? techStatus;

  Future<void> getallTechnation({
    required String userFullName,
    bool retry = false,
  }) async {
    techStatus = NetworkStatus.loading;

    if (retry) {
      notifyListeners();
    }

    try {
      Map<String, dynamic> params = {};

      if (userFullName == '') {
        params = {};
      } else {
        params = {
          "search": userFullName,
        };
      }

      Uri uri = Uri.parse('${base_url}Technicals/get-all-technical');
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

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.statusCode);
        List jsonResponse = jsonDecode(response.body);
        allTechnicals = jsonResponse.map((e) => Technical.fromJson(e)).toList();

        log('all Technicals length ${allTechnicals.length}');

        techStatus = NetworkStatus.success;
      } else {
        log('Error get ready plans > ${response.body}');

        techStatus = NetworkStatus.error;
      }
    } catch (e) {
      log('catch get all Technicals> ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> addNewTechnical({
    required String fullName,
    required String Password,
    File? UploadImage,
    required String mobileNumber,
    required String Email,
    required String UserName,
  }) async {
    try {
      showDialog(
        context: navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (ctx) => LoadingDialog(),
      );

      var request = MultipartRequest(
        'POST',
        Uri.parse('${base_url}Technicals/create-new-technical-account'),
      );

      request.fields['fullName'] = fullName;
      request.fields['Password'] = Password;
      request.fields['mobileNumber'] = mobileNumber;
      request.fields['Email'] = Email;
      request.fields['UserName'] = UserName;
      request.fields['UserRole'] = 1.toString();
      if (UploadImage != null) {
        request.files.add(
          await http.MultipartFile(
            'UploadImage',
            await UploadImage.readAsBytes().asStream(),
            await UploadImage.lengthSync(),
            filename: await UploadImage.path.split('/').last,
          ),
        );
      }
      var headers = {
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Preferences.instance.getUserToken}'
      };
      request.headers.addAll(headers);
      var streamResponse = await request.send();
      Response response = await Response.fromStream(streamResponse);
      var r = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Login Success');
        log(response.body);
        MagicRouter.pop();
        bool navigated = false;
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => InfoDialog(
            content: 'تم تسجيل حساب جديد بنجاح',
          ),
        ).then((value) {
          navigated = true;
          MagicRouter.navigateAndPopAll(TechnicianViewScreen());
        });

        Future.delayed(
          Duration(seconds: 3),
          () {
            if (!navigated) {
              if (Navigator.canPop(navigatorKey.currentContext!)) {
                Navigator.pop(navigatorKey.currentContext!);
              }
              MagicRouter.navigateAndPopAll(TechnicianViewScreen());
            }
          },
        );
      } else {
        MagicRouter.pop();
        print('error create tech > ${response.body}');

        String errorString =
            r.values.first.toString().replaceAll(RegExp(r'[\[\]]'), '');

        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (ctx) => ErrorDialog(
            text: '${errorString}',
          ),
        );
      }
    } catch (e) {
      print('catch add new technical ${e.toString()}');
      MagicRouter.pop();
    }
  }

  Future<void> pickImageFromGallary() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage == null) return;
    log(returnedImage.path);

    selectedTechnicalImage = File(returnedImage.path);
    notifyListeners();
  }
}
