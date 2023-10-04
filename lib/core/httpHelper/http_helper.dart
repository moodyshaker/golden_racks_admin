import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../appStorage/shared_preference.dart';
import 'header_config.dart';

// final String base_url = 'https://malqaapi.webxy.net/api/';
final String base_url = 'http://75.119.156.82/api/';
final String base_url_image = 'http://75.119.156.82/';

class HttpHelper {
  static final HttpHelper instance = HttpHelper._instance();

  HttpHelper._instance();

  Future<Response> httpPost(
    String path,
    bool withAuth, {
    Map<String, dynamic>? body,
    bool withoutPath = false,
  }) async {
    final Response r = await post(
      Uri.parse(withoutPath ? path : '$base_url$path'),
      body: json.encode(body),
      headers: withAuth
          ? await HeaderConfig.getHeaderWithToken()
          : await HeaderConfig.getHeader(),
    );
    return r;
  }

  Future<Response> httpDelete(String path, bool withAuth,
      {Map<String, dynamic>? body}) async {
    final Response r = await delete(Uri.parse('$base_url$path'),
        body: body == null ? null : json.encode(body),
        headers: withAuth
            ? await HeaderConfig.getHeaderWithToken()
            : await HeaderConfig.getHeader());
    return r;
  }

  Future<Response> httpGet(String path, bool withAuth) async {
    final Response r = await get(Uri.parse('$base_url$path'),
        headers: withAuth
            ? await HeaderConfig.getHeaderWithToken()
            : await HeaderConfig.getHeader());
    return r;
  }

  Future<Response> httpPut(String path, bool withAuth,
      {Map<String, dynamic>? body}) async {
    final Response r = await put(Uri.parse('$base_url$path'),
        body: json.encode(body),
        headers: withAuth
            ? await HeaderConfig.getHeaderWithToken()
            : await HeaderConfig.getHeader());
    return r;
  }

  Future<Response> updateProfileWithImage(
      {required File imageFile,
      required String path,
      required String name,
      required String phone,
      required String email}) async {
    var request = MultipartRequest(
      'PUT',
      Uri.parse('$base_url$path'),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      "Authorization": 'Bearer ${Preferences.instance.getUserToken}'
    };
    request.files.add(
      MultipartFile(
        'Photo',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: imageFile.path.split('/').last,
      ),
    );

    request.fields['Name'] = name;
    request.fields['Email'] = email;
    request.fields['Mobile'] = phone;
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    Response r = await Response.fromStream(res);
    return r;
  }

  Future<Response> updateImage({
    required File imageFile,
    required String phoneNumber,
    required String path,
  }) async {
    var request = MultipartRequest(
      'PUT',
      Uri.parse('$base_url$path'),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      "AppToken": '${Preferences.instance.getUserToken}'
    };
    request.files.add(
      MultipartFile(
        'photo',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: imageFile.path.split('/').last,
      ),
    );
    request.fields['PhoneNumber'] = phoneNumber;
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    Response r = await Response.fromStream(res);
    return r;
  }

  Future<Response> addNewProduct({
    required List<File> images,
    required String path,
    required String brief,
    required String catId,
    required String userId,
    required String name,
    required String coins,
  }) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse('$base_url$path'),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      "AppToken": '${Preferences.instance.getUserToken}'
    };
    // request.files.addAll(images
    //     .map((e) => MultipartFile(
    //         'Photos[]', e.readAsBytes().asStream(), e.lengthSync(),
    //         filename: e.path.split('/').last))
    //     .toList());
    List<MultipartFile> newList = <MultipartFile>[];
    for (int i = 0; i < images.length; i++) {
      var stream = ByteStream(images[i].openRead());
      var length = await images[i].length();
      var multipartFile = MultipartFile("Photos", stream, length,
          filename: basename(images[i].path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    request.fields['Brief'] = brief;
    request.fields['CategoryId'] = catId;
    request.fields['ValuesCoin'] = coins;
    request.fields['Name'] = name;
    request.fields['UserId'] = userId;
    request.fields['Id'] = '0';
    request.fields['PublicationYear'] =
        DateFormat('yyyy').format(DateTime.now());
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    Response r = await Response.fromStream(res);
    return r;
  }

  Future<Response> editProduct({
    required List<File> images,
    required String path,
    required String brief,
    required String catId,
    required String userId,
    required String productId,
    required String name,
    required String coins,
  }) async {
    var request = MultipartRequest(
      'PUT',
      Uri.parse('$base_url$path'),
    );
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Accept-Language': 'ar',
      'Accept': 'application/json',
      "AppToken": '${Preferences.instance.getUserToken}'
    };
    // request.files.addAll(images
    //     .map((e) => MultipartFile(
    //         'Photos[]', e.readAsBytes().asStream(), e.lengthSync(),
    //         filename: e.path.split('/').last))
    //     .toList());
    List<MultipartFile> newList = <MultipartFile>[];
    for (int i = 0; i < images.length; i++) {
      var stream = ByteStream(images[i].openRead());
      var length = await images[i].length();
      var multipartFile = MultipartFile("Photos", stream, length,
          filename: basename(images[i].path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    request.fields['Brief'] = brief;
    request.fields['CategoryId'] = catId;
    request.fields['ValuesCoin'] = coins;
    request.fields['Name'] = name;
    request.fields['UserId'] = userId;
    request.fields['Id'] = productId;
    request.fields['PublicationYear'] =
        DateFormat('yyyy').format(DateTime.now());
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    Response r = await Response.fromStream(res);
    return r;
  }
}
