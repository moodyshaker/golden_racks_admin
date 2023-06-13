import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageCubit extends ChangeNotifier {
  static LanguageCubit get(context) => Provider.of<LanguageCubit>(context);

  static LanguageCubit listenFalse(context) =>
      Provider.of<LanguageCubit>(context, listen: false);

  Locale _locale = Locale('ar', 'EG');

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  Locale get locale => _locale;
}
