

import 'package:Attendee/Data/Models/UserOtpResponseModel.dart';

import '../../../../../Data/Models/StateModel.dart';
import '../../../../../Data/Providers/UserProvider.dart';
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../UI/Widgets/AppButton.dart';
import '../../../../../UI/Widgets/AppTextField.dart';
import '../../../../../Utils/Extintions.dart';
import '../../../../../Utils/ValidationUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../UI/Dialogs/LoadingDialog.dart';
import '../../../Constants.dart';
import '../../../Data/Models/UserModel.dart';
import '../../../Data/Models/UserRegisterRequest.dart';
import '../../../Utils/Snaks.dart';


class UserSignUpScreen extends ConsumerStatefulWidget {
  final VoidCallback loginPressed;
  UserSignUpScreen({Key? key, required this.loginPressed}) : super(key: key);
  @override
  _UserSignUpScreenState createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends ConsumerState<UserSignUpScreen> {

  TextEditingController _emailControl = TextEditingController();
  TextEditingController _nameControl = TextEditingController();
  TextEditingController _passwordControl = TextEditingController();
  TextEditingController _userNameControl = TextEditingController();
  TextEditingController _collegeNameControl = TextEditingController();
  TextEditingController _phoneControl = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormFieldState> _confirmPasswordKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    ref.listen<StateModel<UserOtpResponseModel?>>(userRegisterNotifier, (previous, next) {
      next.handelStateWithoutWidget(
        onLoading: (state){},
        onFailure: (state){
          context.closeDialog();
          SnakeBar.showSnakeBar(context, isSuccess: false, message: appLocalizations.translate(next.message??"something_wrong"));
        },
        onSuccess: (state){
          SnakeBar.showSnakeBar(context, isSuccess: true, message: state.message ?? "");
          context.closeDialog();
          context.push(R_MainScreen,extra : state.data);
        }
      );
    });

    return Container(
      width: size.width,
      height: size.height * 0.7,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18)),
          color: themeData.backgroundColor
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextField(
                hint: appLocalizations.translate("email"),
                textEditingController: _emailControl,
                label: appLocalizations.translate("email"),
                borderRidus: BorderRadius.circular(25),
                textFieldColor: context.appTheme.scaffoldBackgroundColor,
                validate: ValidationUtils.required(appLocalizations.translate('required')) ,
                width: size.width * 0.9,
              ),
              const SizedBox(height: 10,),
              AppTextField(
                hint: appLocalizations.translate("name"),
                textEditingController: _nameControl,
                label: appLocalizations.translate("name"),
                borderRidus: BorderRadius.circular(25),
                textFieldColor: context.appTheme.scaffoldBackgroundColor,
                validate: ValidationUtils.required(appLocalizations.translate('required')) ,
                width: size.width * 0.9,
              ),
              const SizedBox(height: 10,),
              AppTextField(
                hint: appLocalizations.translate("college_name"),
                textEditingController: _collegeNameControl,
                label: appLocalizations.translate("college_name"),
                borderRidus: BorderRadius.circular(25),
                textFieldColor: context.appTheme.scaffoldBackgroundColor,
                validate: ValidationUtils.required(appLocalizations.translate('required')) ,
                width: size.width * 0.9,
              ),
              const SizedBox(height: 10,),
              AppTextField(
                hint: appLocalizations.translate("phone"),
                textEditingController: _phoneControl,
                label: appLocalizations.translate("phone"),
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
                validate: ValidationUtils.required(appLocalizations.translate('required')) ,
                textFieldColor:  context.appTheme.scaffoldBackgroundColor,
                width: size.width * 0.9,
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: TextButton(
                    onPressed: widget.loginPressed,
                    child: RichText(
                      text: TextSpan(
                          text: appLocalizations.translate("have_account"),
                          style: themeData.textTheme.bodyText1,
                          children: [
                            TextSpan(
                                text: "   ${appLocalizations.translate("login")}",
                                style: TextStyle(
                                    fontSize: AppColors
                                        .appTextTheme.bodyText1?.fontSize,
                                    color: AppColors.mainAppColorLight))
                          ]),
                    )),
              ),
              AppButton(
                onPress: () {
                  print("Valid ${_formKey.currentState?.validate()}");
                  if(_formKey.currentState?.validate() == true){
                    context.showLoadingDialog();
                    ref.read(userRegisterNotifier.notifier).signUp(UserRegisterRequest(
                        _emailControl.text,
                        _nameControl.text,
                        _passwordControl.text,
                        _collegeNameControl.text,
                        _phoneControl.text,
                    ));
                  }
                },
                text: appLocalizations.translate("sign_up"),
                radius: BorderRadiusDirectional.circular(25),
                width: size.width * 0.7,
                backColor: AppColors.mainAppColorLight,
                height: 50,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
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
