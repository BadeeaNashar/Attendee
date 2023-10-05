import 'package:Attendee/Data/Models/UserLoginRequest.dart';
import 'package:Attendee/Data/Models/UserOtpResponseModel.dart';

import '../../../../../Data/Models/StateModel.dart';
import '../../../../../Data/Models/UserModel.dart';
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../UI/Widgets/AppButton.dart';
import '../../../../../UI/Widgets/AppTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Utils/Extintions.dart';
import '../../../../../UI/Dialogs/LoadingDialog.dart';
import '../../../Constants.dart';
import '../../../Data/Providers/UserProvider.dart';
import '../../../Utils/Snaks.dart';

class UserLoginScreen extends StatefulWidget {
  final VoidCallback signUpPressed;
  UserLoginScreen({Key? key, required this.signUpPressed})
      : super(key: key);
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController _emailControl = TextEditingController();

  TextEditingController _passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18)),
            color: themeData.backgroundColor
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextField(
                hint: appLocalizations.translate("userName"),
                textEditingController: _emailControl,
                label: appLocalizations.translate("userName"),
                borderRidus: BorderRadius.circular(25),
                textFieldColor:  context.appTheme.scaffoldBackgroundColor,
                width: size.width * 0.9,
              ),
              const SizedBox(height: 10,),
              AppTextField(
                hint: appLocalizations.translate("password"),
                textEditingController: _passwordControl,
                label: appLocalizations.translate("password"),
                borderRidus: BorderRadius.circular(25),
                secured: true,
                textFieldColor:  context.appTheme.scaffoldBackgroundColor,
                width: size.width * 0.9,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: TextButton(
                    onPressed: widget.signUpPressed,
                    child: RichText(
                      text: TextSpan(
                          text: appLocalizations.translate("no_have_account"),
                          style:  themeData.textTheme.bodyText1,
                          children: [
                            TextSpan(
                                text: "   ${appLocalizations.translate("sign_up")}",
                                style: TextStyle(
                                    fontSize: AppColors
                                        .appTextTheme.bodyText1?.fontSize,
                                    color: AppColors.mainAppColorLight))
                          ]),
                    )),
              ),
              LoginButton(_emailControl,_passwordControl),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      );
  }

  @override
  void dispose() {
    _emailControl.dispose();
    _passwordControl.dispose();
    super.dispose();
  }
}

class LoginButton extends ConsumerWidget {
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  LoginButton(this.emailEditingController, this.passwordEditingController);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    ref.listen(userLoginNotifier, (previous, next) {
      next.handelStateWithoutWidget(
          onLoading: (state){},
          onFailure: (state){
            context.closeDialog();
            SnakeBar.showSnakeBar(context, isSuccess: false, message: context.getLocaleString(next.message??"something_wrong"));
          },
          onSuccess: (state){
            SnakeBar.showSnakeBar(context, isSuccess: true, message: context.getLocaleString(next.message??""));
            context.closeDialog();
            context.push(R_MainScreen,extra : state.data);
          }
      );
    });

    return AppButton(
      onPress: () {
        context.showLoadingDialog();
        if(emailEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty){
          ref.read(userLoginNotifier.notifier).login(UserLoginRequest(emailEditingController.text, passwordEditingController.text));
        }
      },
      text: context.getLocaleString("login"),
      radius: BorderRadiusDirectional.circular(25),
      width: context.getScreenSize.width * 0.7,
      backColor: AppColors.mainAppColorLight,
      height: 50,
    );
  }
}
