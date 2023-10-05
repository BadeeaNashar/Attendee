import 'package:flutter/material.dart';

class AppColors {

  static const Color mainAppColorLight = Color(0xFF00A487);
  static const Color mainAppColorDark = Color(0xFF00836C);

  static const Color secondaryAppColorLight = Color(0xFF484848);
  static const Color secondaryAppColorDark = Color(0xFF00A487);

  static const Color redColor = Color(0xFFBC5555);
  static const Color greenColor = Color(0xFF61BC55);
  static const Color playGroundColor = Color(0xFF32d364);
  static const Color deepPlayGroundColor = Color(0xFF658d5d);
  static const Color orangeColor = Color(0xFFFF9645);
  static const Color blue = Color(0xFF1256d2);

  static const Color mainBackgroundLightColor = Color(0xFFF2FBFD);
  static const Color mainBackgroundDarkColor = Color(0xFF0E0314);
  static const Color mainOverlayBackgroundDarkColor = Color(0xFF0E0314);
  static const Color mainBackgroundSemiLightColor = Color(0xFFe8eceb);
  static const Color mainBackgroundSemiDarkColor = Color(0xFF0E0322);
  static const Color cardColor = Color(0xFF11091f);
  static const Color lightTextColor = Colors.white;
  static Color? lightDetailTextColor = Colors.grey[200];
  static const Color darkDetailTextColor = Colors.black54;
  static const Color darkTextColor = Colors.black;

  static const MaterialColor appSwatch = MaterialColor(
    0xFF00A487,
    <int, Color>{
      50: Color(0xFF00A487),
      100: Color(0xFF00A487),
      200: Color(0xFF00A487),
      300: Color(0xFF00A487),
      400: Color(0xFF00A487),
      500: Color(0xFF00A487),
      600: Color(0xFF00A487),
      700: Color(0xFF00A487),
      800: Color(0xFF00A487),
      900: Color(0xFF00A487),
    },
  );

  static const TextTheme appTextTheme = TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
    bodyText2: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
    headline4: TextStyle(
        color: mainAppColorLight, fontSize: 16, fontWeight: FontWeight.bold),
    headline1: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    headline2: TextStyle(
        color: lightTextColor, fontSize: 13, fontWeight: FontWeight.bold),
    headline3: TextStyle(
        color: mainAppColorLight, fontSize: 18, fontWeight: FontWeight.w600),
    subtitle1: TextStyle(
        color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal),
    subtitle2: TextStyle(
        color: Colors.white, fontSize: 13, fontWeight: FontWeight.normal),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: mainAppColorLight,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)
    ),
    primaryColorLight: mainAppColorLight,
    scaffoldBackgroundColor: mainBackgroundLightColor,
    bottomAppBarColor: Colors.white,
    backgroundColor: Colors.white,
    dividerColor:Colors.transparent,
    expansionTileTheme: const ExpansionTileThemeData(backgroundColor: Colors.transparent,collapsedBackgroundColor: Colors.transparent),
    radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(appSwatch)),
    hintColor: Colors.grey,
    
    primarySwatch: appSwatch,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainBackgroundDarkColor))),
    popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
    checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.all(Colors.white),fillColor: MaterialStateProperty.all(appSwatch)),
    textTheme: TextTheme(
        bodyText1: const TextStyle(
            color: darkTextColor, fontSize: 14, fontWeight: FontWeight.normal),
        bodyText2: const TextStyle(
            color: darkTextColor, fontSize: 16, fontWeight: FontWeight.w600),
        headline1: const TextStyle(
            color: darkTextColor, fontSize: 18, fontWeight: FontWeight.bold),
        headline2: const TextStyle(
            color: darkTextColor, fontSize: 15, fontWeight: FontWeight.bold),
        headline3: const TextStyle(
            color: darkTextColor, fontSize: 12, fontWeight: FontWeight.bold),
        subtitle1: const TextStyle(
            color: darkTextColor, fontSize: 13, fontWeight: FontWeight.normal),
        subtitle2: const TextStyle(
            color: darkDetailTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
        caption: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.normal),
        button: const TextStyle(
            color: darkTextColor, fontSize: 13, fontWeight: FontWeight.normal)),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: secondaryAppColorDark,
    primaryColorLight: mainAppColorLight,
    expansionTileTheme: const ExpansionTileThemeData(backgroundColor: Colors.transparent,collapsedBackgroundColor: Colors.transparent),
    radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(appSwatch)),
    appBarTheme: const AppBarTheme(
        backgroundColor: mainBackgroundSemiDarkColor,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    hintColor: Colors.grey,
    primarySwatch: appSwatch,
    dividerColor:Colors.transparent,
    scaffoldBackgroundColor: mainBackgroundDarkColor,
    
    backgroundColor: mainBackgroundSemiDarkColor,
    bottomAppBarColor: mainBackgroundSemiDarkColor,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(mainBackgroundDarkColor))),
    checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.all(Colors.white),fillColor: MaterialStateProperty.all(appSwatch)),
    popupMenuTheme: const PopupMenuThemeData(color:mainBackgroundSemiDarkColor),
    cardColor: cardColor,
    textTheme: TextTheme(
      bodyText1: const TextStyle(
          color: lightTextColor, fontSize: 14, fontWeight: FontWeight.normal),
      bodyText2: const TextStyle(
          color: lightTextColor, fontSize: 16, fontWeight: FontWeight.w600),
      headline1: const TextStyle(
          color: lightTextColor, fontSize: 18, fontWeight: FontWeight.bold),
      headline2: const TextStyle(
          color: lightTextColor, fontSize: 15, fontWeight: FontWeight.bold),
      headline3: const TextStyle(
          color: lightTextColor, fontSize: 12, fontWeight: FontWeight.bold),
      subtitle1: const TextStyle(
          color: lightTextColor, fontSize: 13, fontWeight: FontWeight.normal),
      subtitle2: TextStyle(
          color: lightDetailTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      button: const TextStyle(
          color: lightTextColor, fontSize: 13, fontWeight: FontWeight.normal),
      caption: TextStyle(
          color: Colors.grey[300], fontSize: 12, fontWeight: FontWeight.normal),
    ),
  );

  static ThemeData expandedTileTheme =
      ThemeData(dividerColor: Colors.transparent);

}

const appGradiant = LinearGradient(
  colors: [
    AppColors.mainAppColorLight,
    AppColors.secondaryAppColorLight
  ],
  begin: AlignmentDirectional.bottomStart,
  end: AlignmentDirectional.topEnd,
);
