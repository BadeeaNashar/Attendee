import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../UI/Widgets/FlatAppButton.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../../Data/Providers/UserProvider.dart';

Future<dynamic> showAppDialog(BuildContext context, Widget dialog) async {
  var result = await showModal(
      context: context,
      configuration: const FadeScaleTransitionConfiguration(
          barrierDismissible: false,
          transitionDuration: Duration(milliseconds: 500)),
      builder: (context) => dialog);
  return result;
}

extension Dialogs on BuildContext {

  closeDialog({Object? data}){
    Navigator.of(this).pop(data);
  }

  showLoadingDialog(){
    showAppDialog(this, LoadingWidget());
  }

  showSuccessDialog({ required String message,String? description,VoidCallback? onClose}) async {
    showAppDialog(this , Dialog(
      backgroundColor:  Theme.of(this).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle,color: AppColors.appSwatch,size: 100,),
            const SizedBox(height: 20,),
            Text(message,style: Theme.of(this).textTheme.bodyText2?.copyWith(color: AppColors.appSwatch),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
            if(description != null) Text(description,style: Theme.of(this).textTheme.subtitle1,textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            FlatAppButton(onPress: (){
              Navigator.pop(this);
              onClose?.call();
              },text: AppLocalizations.of(this)!.translate('close'),txtColor: AppColors.appSwatch,)
          ],
        ),
      ),
    ),);
  }

  showFailDialog({ required String message,String? description,VoidCallback? onClose}) async {
    showAppDialog(this , Dialog(
      backgroundColor:  Theme.of(this).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error,color: AppColors.redColor,size: 100,),
            const SizedBox(height: 20,),
            Text(message,style: Theme.of(this).textTheme.bodyText2?.copyWith(color: AppColors.redColor),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
            if(description != null) Text(description,style: Theme.of(this).textTheme.subtitle1,textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            FlatAppButton(onPress: (){
              Navigator.pop(this);
              onClose?.call();
            },text: AppLocalizations.of(this)!.translate('close'),txtColor: AppColors.appSwatch,)
          ],
        ),
      ),
    ),);
  }

  showAlertDialog({ required String message,String? description,Function(bool)? onClose}) async {
    showAppDialog(this , Dialog(
      backgroundColor:  Theme.of(this).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info,color: AppColors.redColor,size: 30,),
            const SizedBox(height: 20,),
            Text(message,style: Theme.of(this).textTheme.bodyText2?.copyWith(color: AppColors.redColor),textAlign: TextAlign.center,),
            const SizedBox(height: 8,),
            if(description != null) Text(description,style: Theme.of(this).textTheme.subtitle1,textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatAppButton(onPress: (){
                  Navigator.pop(this);
                  onClose?.call(true);
                },text: AppLocalizations.of(this)!.translate('yes'),txtColor: AppColors.appSwatch,),
                FlatAppButton(onPress: (){
                  Navigator.pop(this);
                  onClose?.call(false);
                },text: AppLocalizations.of(this)!.translate('no'),txtColor: AppColors.redColor,),
              ],
            )
          ],
        ),
      ),
    ),);
  }

}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator(),),
          Text(AppLocalizations.of(context)!.translate("loading"),style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.appSwatch),)
        ],
      ),);
  }
}
