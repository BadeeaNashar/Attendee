import 'package:Attendee/UI/Screens/AuthPage/AuthScreen.dart';
import 'package:Attendee/UI/Widgets/AppButton.dart';
import 'package:Attendee/UI/Widgets/SvgIcons.dart';
import 'package:Attendee/Utils/Extintions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Data/Providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../Constants.dart';
import '../../Data/Models/User.dart';
import '../../Localization/LanguageProvider.dart';
import '../../main.dart';
import '../Theme/AppColors.dart';
import '../Theme/AppThemeHandler.dart';



class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  double _opc = 0.0;
  late AppThemeMode _appThemeMode;
  bool isThereUser = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      if(FirebaseAuth.instance.currentUser != null){
        context.push(R_MainScreen);
      }else{
        setState(() => _opc = 1.0);
      }
    });
    //setupInteractedMessage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: SingleChildScrollView(
        child: Center(
          child:  Container(
            width: context.getScreenSize.width,
            height: context.getScreenSize.height,
            color: AppColors.mainAppColorLight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                AnimatedPadding(duration: const Duration(milliseconds: 500),padding: EdgeInsets.only(top: _opc == 1.0 ? 0 : 130), child: SVGIcons.appLogo(size: const Size(200, 200),color: Colors.white)),
                const Spacer(),
                AnimatedOpacity(opacity: _opc , duration: const Duration(milliseconds: 500),
                  child: AuthScreen(),)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.mainBackgroundLightColor,
    );
  }
}
