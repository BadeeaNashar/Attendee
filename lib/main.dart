
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants.dart';
import '../../../../../UI/Screens/SplashScreen.dart';
import 'Localization/AppLocalizations.dart';
import 'Localization/LanguageProvider.dart';
import 'UI/Screens/MainPage/MainPage.dart';
import 'UI/Theme/AppColors.dart';
import 'firebase_options.dart';


late SharedPreferences prefs;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "de",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //SharedPrefs
  prefs = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColors.mainAppColorLight));
  //Main App
  runApp(ProviderScope(child: MyApp()));

}


class MyApp extends ConsumerWidget {
  final appLang;
  MyApp({Key? key, this.appLang}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ThemeProvider(
      initTheme: Theme.of(context),
      duration: const Duration(milliseconds: 500),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tag',
        themeMode:ThemeMode.light,
        theme: AppColors.lightTheme,
        darkTheme: AppColors.darkTheme,

        locale: ref.watch(langProvider)
        ,supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: R_splashScreenRout,
        builder: (BuildContext context, GoRouterState state) => SplashScreen(),
      ),

      GoRoute(
        path: R_MainScreen,
        builder: (BuildContext context, GoRouterState state) =>  MainPage(),
      ),
    ],
  );
}
