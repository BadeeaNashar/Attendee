import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'LanguageType.dart';

class LanguageProvider extends StateNotifier<Locale> {

  final Ref ref;
  LanguageProvider(this.ref) : super( Locale(LanguageType.ar));

  Locale _appLocale =  Locale(LanguageType.ar);
  bool isEnLanguage = false ;


  Locale get appLocal => _appLocale;
  bool get isEnglish => isEnLanguage;

  fetchLocale(String? userLang) async {
    if(userLang != null){
      _appLocale = Locale(userLang);
    }else{
      _appLocale =  Locale(LanguageType.ar);
    }
    print(_appLocale);
    state = _appLocale;
  }

  String changeLanguage() {
    _appLocale = _appLocale ==   Locale(LanguageType.en) ?  Locale(LanguageType.ar) :  Locale(LanguageType.en);
    isEnLanguage = _appLocale ==  Locale(LanguageType.en) ? true : false;
    state = _appLocale;
    print("Changed");
    return _appLocale.languageCode;
  }
}

final langProvider = StateNotifierProvider<LanguageProvider,Locale>((ref) => LanguageProvider(ref));