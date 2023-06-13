import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _preferences;
  static final Preferences instance = Preferences._instance();
  static const String fcmToken = 'malqa_fcmToken';
  static const String orgFcmToken = 'malqa_org_fcmToken';
  static const String id = 'malqa_id';
  static const String orgId = 'malqa_org_id';
  static const String name = 'malqa_name';
  static const String orgName = 'malqa_org_name';
  static const String token = 'malqa_token';
  static const String orgToken = 'malqa_org_token';
  static const String phone = 'malqa_phone';
  static const String orgPhone = 'malqa_org_phone';
  static const String email = 'malqa_email';
  static const String orgEmail = 'malqa_org_email';
  static const String image = 'malqa_image';
  static const String orgImage = 'malqa_org_image';
  static const String lang = 'malqa_lang';
  static const String isRemember = 'malqa_remember';
  static const String type = 'malqa_type';

  Preferences._instance();

  Future<SharedPreferences?> initPref() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<bool> setFcmToken(String? value) async {
    bool isSet = await _preferences!.setString(fcmToken, value!);
    return isSet;
  }

  Future<bool> setOrgFcmToken(String? value) async {
    bool isSet = await _preferences!.setString(orgFcmToken, value!);
    return isSet;
  }

  Future<bool> setUserName(String value) async {
    bool isSet = await _preferences!.setString(name, value);
    return isSet;
  }

  Future<bool> setOrgUserName(String value) async {
    bool isSet = await _preferences!.setString(orgName, value);
    return isSet;
  }

  Future<bool> setUserPhone(String value) async {
    bool isSet = await _preferences!.setString(phone, value);
    return isSet;
  }

  Future<bool> setOrgUserPhone(String value) async {
    bool isSet = await _preferences!.setString(orgPhone, value);
    return isSet;
  }

  Future<bool> setUserEmail(String value) async {
    bool isSet = await _preferences!.setString(email, value);
    return isSet;
  }

  Future<bool> setOrgUserEmail(String value) async {
    bool isSet = await _preferences!.setString(orgEmail, value);
    return isSet;
  }

  Future<bool> setUserType(String value) async {
    bool isSet = await _preferences!.setString(type, value);
    return isSet;
  }

  Future<bool> setLang(String value) async {
    bool isSet = await _preferences!.setString(lang, value);
    return isSet;
  }

  Future<bool> setUserImage(String value) async {
    bool isSet = await _preferences!.setString(image, value);
    return isSet;
  }

  Future<bool> setOrgUserImage(String value) async {
    bool isSet = await _preferences!.setString(orgImage, value);
    return isSet;
  }

  Future<bool> setRememberMe(int v) async {
    bool isSet = await _preferences!.setInt(isRemember, v);
    return isSet;
  }

  Future<bool> setUserId(String value) async {
    bool isSet = await _preferences!.setString(id, value);
    return isSet;
  }

  Future<bool> setOrgUserId(String value) async {
    bool isSet = await _preferences!.setString(orgId, value);
    return isSet;
  }

  Future<bool> setUserToken(String value) async {
    bool isSet = await _preferences!.setString(token, value);
    return isSet;
  }

  Future<bool> setOrgUserToken(String value) async {
    bool isSet = await _preferences!.setString(orgToken, value);
    return isSet;
  }

  Future<bool> logout() async {
    bool isSet = await _preferences!.clear();
    return isSet;
  }

  String get getFcmToken => _preferences!.getString(fcmToken) ?? '';

  String get getOrgFcmToken => _preferences!.getString(orgFcmToken) ?? '';

  String get getUserId => _preferences!.getString(id) ?? '';

  String get getOrgUserId => _preferences!.getString(orgId) ?? '';

  String get getUserName => _preferences!.getString(name) ?? '';

  String get getOrgUserName => _preferences!.getString(orgName) ?? '';

  String get getUserImage => _preferences!.getString(image) ?? '';

  String get getOrgUserImage => _preferences!.getString(orgImage) ?? '';

  int get getRememberMe => _preferences!.getInt(isRemember) ?? 0;

  String get getUserToken => _preferences!.getString(token) ?? '';

  String get getOrgUserToken => _preferences!.getString(orgToken) ?? '';

  String get getUserEmail => _preferences!.getString(email) ?? '';

  String get getOrgUserEmail => _preferences!.getString(orgEmail) ?? '';

  String get getUserType => _preferences!.getString(type) ?? '';

  String get getUserPhone => _preferences!.getString(phone) ?? '';

  String get getOrgUserPhone => _preferences!.getString(orgPhone) ?? '';

  String get getLanguage => _preferences!.getString(lang) ?? 'en';
}
