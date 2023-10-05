import 'dart:convert';
import '../../../../../Data/Models/StateModel.dart';
import '../../../../../ViewModels/UserViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../Models/Student.dart';
import '../Models/User.dart';
import '../Models/UserOtpResponseModel.dart';

class UserModelProvider extends StateNotifier<User?> {
  final Ref ref;

  UserModelProvider(this.ref) : super(null) {
    String? userJson = prefs.getString("User");
    if(userJson != null){
      Map<String,dynamic> userJsonObj = json.decode(userJson);
      state = User.fromJson(userJsonObj);
    }
  }

  void updateUserData(User? userModel){
    state = userModel;
  }
}

final userProvider = StateNotifierProvider<UserModelProvider,User?>((ref)  {
  return UserModelProvider(ref);});


final userLoginNotifier = StateNotifierProvider<UserLoginUseCase,StateModel<UserOtpResponseModel?>>((ref)  {
  return UserLoginUseCase(ref);
});

final userRegisterNotifier = StateNotifierProvider<UserSignUpUseCase,StateModel<UserOtpResponseModel?>>((ref)  {
  return UserSignUpUseCase(ref);
});

final userDetailsNotifier = StateNotifierProvider<UserDetailsUseCase,StateModel<User?>>((ref)  {
  return UserDetailsUseCase(ref);
});

final setAttendanceNotifier = StateNotifierProvider<SetAttendanceUseCase,StateModel<bool>>((ref)  {
  return SetAttendanceUseCase(ref);
});

final getAttendanceNotifier = StateNotifierProvider<GetAttendanceUseCase,StateModel<List<Student>>>((ref)  {
  return GetAttendanceUseCase(ref);
});

final deleteAttendanceNotifier = StateNotifierProvider<DeleteAttendanceUseCase,StateModel<bool>>((ref)  {
  return DeleteAttendanceUseCase(ref);
});

final bottomNavVisibilityNotifier = StateNotifierProvider<BottomNavState,bool>((ref)  {
return BottomNavState(ref);
});