import 'package:flutter/cupertino.dart';

class Validations {
  static bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  static bool passwordVerified(String s) =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(s);

  static bool validateUserEmail(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
    return emailValid;
  }
}
