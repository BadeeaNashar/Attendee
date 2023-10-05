import 'package:Attendee/Data/Models/StateModel.dart';
import 'package:Attendee/Data/Models/User.dart';
import 'package:Attendee/Data/Providers/UserProvider.dart';
import 'package:Attendee/UI/Widgets/AppButton.dart';
import 'package:Attendee/Utils/Extintions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../Constants.dart';
import '../../Theme/AppColors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userDetailsNotifier.notifier).getDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userDetailsNotifier);

    if(userState.state == DataState.LOADING) return Center(child: CircularProgressIndicator(),);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UserInfo(),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: AppButton(onPress: () async {
              await auth.FirebaseAuth.instance.signOut();
              context.go(R_splashScreenRout);
            },width: context.getScreenSize.width,child: Text("تسجيل الخروج"),height: 60,),
          )
        ],
      ),
    );
  }
}

class UserInfo extends ConsumerStatefulWidget {
  final User? user;
  const UserInfo({Key? key, this.user}) : super(key: key);

  @override
  ConsumerState<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends ConsumerState<UserInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userDetailsNotifier);
    return Card(
      margin: const EdgeInsets.all(9),
      elevation: 9,
      shadowColor: Colors.grey?.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                elevation: 10,
                shape: const CircleBorder(),
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: FadeInImage.assetNetwork(
                    placeholder: userPlaceholder,
                    image: "",
                    imageErrorBuilder: (context, err, child) =>
                        Image.asset(userPlaceholder),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                userState.data?.fullname ?? "",
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.titleLarge?.copyWith(color: AppColors.mainAppColorDark,fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                userState.data?.college ?? "",
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.titleMedium?.copyWith(color: AppColors.mainAppColorDark,fontSize: 16),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email,size: 16,color: Colors.grey,),
                  SizedBox(width: 9,),
                  Text(
                    userState.data?.email ?? "",
                    textAlign: TextAlign.center,
                    style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone,size: 16,color: Colors.grey,),
                  SizedBox(width: 9,),
                  Text(
                    userState.data?.phone ?? "",
                    textAlign: TextAlign.center,
                    style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

