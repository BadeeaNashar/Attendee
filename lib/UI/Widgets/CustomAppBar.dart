import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Data/Models/User.dart';
import '../../Data/Providers/UserProvider.dart';
import 'SvgIcons.dart';

class CustomAppBar extends StatelessWidget {
final double appBarHeight = 90.0;
final String? title;
final bool navigated;
final Widget? trailingWidget;
final BuildContext appContext;
final bool isCenter;
final VoidCallback? customCallBack;
final Color? appBarColor;
const CustomAppBar({Key? key, this.trailingWidget,this.title , this.navigated = false,required this.appContext, this.customCallBack, this.isCenter = true, this.appBarColor}) : super(key: key);

@override
Widget build(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  return IntrinsicHeight(
    child: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: appBarColor,
      centerTitle: isCenter,
      actions: trailingWidget != null ? [trailingWidget!] : [],
      leading: navigated ? IconButton(onPressed: (){
        try{
          GoRouter.of(appContext).pop(appContext);
        }catch(e){
          Navigator.pop(context);
        }

      }, icon: Icon(Icons.arrow_back,color: themeData.textTheme.bodyText1!.color,),) : SizedBox(),
      title: Text(title??"",textAlign: TextAlign.center,style: themeData.textTheme.headline1,overflow: TextOverflow.ellipsis,),
    ),
  );
}
}

class MainAppBar extends ConsumerWidget {
final double appBarHeight = 90.0;
final String? title;
final bool navigated;
final Widget? trailingWidget;
final BuildContext appContext;
final bool isCenter;
final VoidCallback? customCallBack;
final Color? appBarColor;
const MainAppBar({Key? key, this.trailingWidget,this.title , this.navigated = false,required this.appContext, this.customCallBack, this.isCenter = true, this.appBarColor}) : super(key: key);

@override
Widget build(BuildContext context,WidgetRef ref) {
  final ThemeData themeData = Theme.of(context);
  final User? user = ref.watch(userProvider);
  return IntrinsicHeight(
    child: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor:Colors.transparent,
      actions: [IconButton(onPressed: ()=> launchUrl(Uri.parse("")), icon: SVGIcons.shareIcon()),],
    ),
  );
}
}
