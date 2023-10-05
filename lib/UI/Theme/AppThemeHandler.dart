import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'AppColors.dart';

class AppThemeMode extends ChangeNotifier {
  bool isDark = false;
  ThemeData? appTheme;
  bool toggleThemeMode() {
    isDark = !isDark;
    appTheme = isDark ? AppColors.darkTheme : AppColors.lightTheme;
    //_userData.saveAppTheme(isDark ? "Dark" : "Light");
    //saveTheme();
    notifyListeners();
    return isDark;
  }

 /* void getSavedTheme(UserModel? userModel) async {
    isDark = userModel?.isDarkMoodEnabled??false;
    appTheme = isDark ? AppColors.darkTheme : AppColors.lightTheme;
    notifyListeners();
  }*/

  void saveTheme() async {
//    _prefs = await SharedPreferences.getInstance();
//    _prefs.setBool("isDark", isDark);
    print("Saved");
  }

  Future<bool> themeIsDark() async {
//    _prefs = await SharedPreferences.getInstance();
//    bool isThemeDark = _prefs.getBool('isDark');
//    isDark = isThemeDark ? true : false;
//    notifyListeners();
//    return isThemeDark != null ? isThemeDark : false;
  return false;
  }
}


class DarkLightThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref ref;
  DarkLightThemeNotifier(this.ref): super(ThemeMode.dark);

  void setThemeMode(ThemeMode themeMode){
    state = themeMode;
  }
}


final themeNotifier = StateNotifierProvider<DarkLightThemeNotifier,ThemeMode>((ref) {
  return DarkLightThemeNotifier(ref);
});