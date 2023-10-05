import 'package:animations/animations.dart';
import 'package:Attendee/Utils/Extintions.dart';
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../UI/Widgets/AppButton.dart';
import '../../../../../UI/Widgets/FlatAppButton.dart';
import 'package:flutter/material.dart';

import '../../../Constants.dart';
import 'UserLoginScreen.dart';
import 'UserSignupScreen.dart';

import 'dart:ui' as ui;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AppLocalizations appLocalizations;
  AuthMode _authMode = AuthMode.INITIAL;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 700),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          SharedAxisTransition(
            fillColor: Colors.transparent,
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
      child: getScreen(_authMode),
    );
  }

  Widget getScreen(AuthMode authMode) {
    switch (authMode) {
      case AuthMode.INITIAL:
        return ChooseAuthScreen(onModeSelect: (authMode ) {
          setState(() {
            _authMode = authMode;
          });
        },);
      case AuthMode.LOGIN:
        return UserLoginScreen(signUpPressed : () {
          setState(() {
            _authMode = AuthMode.SIGN_UP;
          });
        });
      case AuthMode.SIGN_UP:
        return UserSignUpScreen(loginPressed: () {
          setState(() {
            _authMode = AuthMode.LOGIN;
          });
        });
      case AuthMode.FORGOT_PASSWORD:
        return ChooseAuthScreen(onModeSelect: (authMode ) {

        },);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ChooseAuthScreen extends StatelessWidget {

  final Function(AuthMode) onModeSelect;
  ChooseAuthScreen({ required this.onModeSelect});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        AppButton(onPress: (){
          onModeSelect(AuthMode.LOGIN);
        },backColor: Colors.white, radius: BorderRadiusDirectional.circular(24),height: 50,width: context.getScreenSize.width * 0.9,child:  Text(context.getLocaleString("login"),style: context.appTheme.textTheme.bodyText2,) ,),
        const SizedBox(height: 24,),
        AppButton(onPress: (){
          onModeSelect(AuthMode.SIGN_UP);
        },backColor: Colors.white, radius: BorderRadiusDirectional.circular(24),height: 50,width: context.getScreenSize.width * 0.9,strokeWidth: 1,outlined: true,child:  Text(context.getLocaleString("sign_up"),style: context.appTheme.textTheme.bodyText2?.copyWith(color: Colors.white),),),
        const SizedBox(height: 40,),
      ],
    );
  }
}

enum AuthMode { INITIAL, LOGIN, SIGN_UP, FORGOT_PASSWORD }
