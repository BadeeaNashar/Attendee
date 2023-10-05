import '../../../../../Localization/AppLocalizations.dart';
import 'package:flutter/material.dart';

extension ContextMethods on BuildContext {
  Size get getScreenSize => MediaQuery.of(this).size;
  String getLocaleString(key) => AppLocalizations.of(this)?.translate(key) ?? "";
  ThemeData get appTheme => Theme.of(this);
}

class CommonUtils {
  static String getCountryFlag(){
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    String country = "EGY";

    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    String flag = String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return flag;
  }
}