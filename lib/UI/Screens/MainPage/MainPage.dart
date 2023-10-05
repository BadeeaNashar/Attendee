import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../../Data/Providers/UserProvider.dart';
import '../../../../../Localization/AppLocalizations.dart';
import '../../../../../UI/Theme/AppColors.dart';
import '../../../../../Utils/Extintions.dart';
import '../../Widgets/SvgIcons.dart';
import 'HomeScreen.dart';
import 'QrScreen.dart';
import 'StoreScreen.dart';
class MainPage extends ConsumerStatefulWidget {
  static GlobalKey mainAppKey = GlobalKey();
  const MainPage({super.key});
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  final PersistentTabController _controller = PersistentTabController();
  late AppLocalizations appLocalizations;

  bool isOpened = false;


  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    appLocalizations = AppLocalizations.of(context)!;
    print("Main Page Rebuild Called");
    return Scaffold(
      key: MainPage.mainAppKey,
      backgroundColor: themeData.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          color: AppColors.mainAppColorLight,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: AppBar(
              centerTitle: true,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40))),
              shadowColor: Colors.grey.withOpacity(0.2),
              title: SVGIcons.appLogo(),
            ),
          ),
        ),
      ),
      body:  BottomNavigation(controller: _controller,),
    );
  }

  void toggleBottomNav(bool hide){

  }
}

class BottomNavigation extends ConsumerStatefulWidget {
  final PersistentTabController controller;
  const BottomNavigation({Key? key, required this.controller}) : super(key: key);

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(context,ref),
      confineInSafeArea: true,
      controller: widget.controller,
      backgroundColor: context.appTheme.bottomAppBarColor,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      navBarHeight: 80,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      bottomScreenMargin: 0,
      onItemSelected: (pos){
        if(pos == 2){
          Future.delayed(Duration(milliseconds: 20),(){
            ref.read(getAttendanceNotifier.notifier).getAttendance();
          });
        }
      },
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 15,
            offset: const Offset(0, 5), //// changes position of shadow
          ),
        ],
        colorBehindNavBar: Theme.of(context).bottomAppBarColor,
      ),
      hideNavigationBar: !ref.watch(bottomNavVisibilityNotifier),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle
          .style15, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const QrScreen(),
      const StoreScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context,WidgetRef ref) {
    return [
      PersistentBottomNavBarItem(
          icon:  const FaIcon(FontAwesomeIcons.house),
          activeColorPrimary: AppColors.mainAppColorLight,
          inactiveColorPrimary: Colors.grey,
          title: context.getLocaleString("home")
      ),
      PersistentBottomNavBarItem(
          icon:  const Icon(Icons.qr_code_2_outlined,color: Colors.white,),
          activeColorPrimary: AppColors.mainAppColorLight,
          title: 'التحضير',
      ),
      PersistentBottomNavBarItem(
          icon:  const FaIcon(FontAwesomeIcons.users),
          inactiveColorPrimary: Colors.grey,
          title: context.getLocaleString("attendance_list"),
          activeColorPrimary: AppColors.mainAppColorLight,
      ),
    ];
  }

}

