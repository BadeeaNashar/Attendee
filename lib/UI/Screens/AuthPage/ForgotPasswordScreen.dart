
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../UI/Widgets/AppTextField.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatefulWidget {
  final VoidCallback onCancel;
  ForgotPasswordScreen({Key? key, required this.onCancel}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(appLocalizations.translate("forgot_password"),style: AppColors.appTextTheme.bodyText1,),
        const SizedBox(height: 15,),
        AppTextField(
          hint: appLocalizations.translate("email"),
          textEditingController: _editingController,
          label: appLocalizations.translate("email"),
          changeValueCallback: (val){

          },
        ),
        const SizedBox(height: 35,),
//        Selector<UserViewModel,ResponseModel>(
//          selector: (context,provider) => provider.getForgotPasswordResponse,
//          builder: (context,response,obj) => response.responseState == ResponseState.Loading ? Center(child: CircularProgressIndicator(),)
//              :
//          AppButton(onPress: () async {
//            if(_editingController.text.isNotEmpty){
//              userViewModel.userForgotPassword(_editingController.text,context);
//            }else{
//              Toasts(context).showToast(message: appLocalizations.translate("please_add_your_email"), success: false);
//            }
//          },text: appLocalizations.translate("reset"),width: size.width,height: 50,),
//        ),
        TextButton(onPressed: widget.onCancel, child: Text(appLocalizations.translate("cancel"),style:  AppColors.appTextTheme.bodyText1,),),
      ],
    );
  }
}
