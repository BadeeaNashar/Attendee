import 'dart:convert';

import 'package:Attendee/Data/Models/Student.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../../Data/Providers/UserProvider.dart';
import '../../../../../main.dart';
import '../Data/Models/StateModel.dart';
import '../Data/Models/User.dart' as appUser;
import '../Data/Models/UserLoginRequest.dart';
import '../Data/Models/UserOtpResponseModel.dart';
import '../Data/Models/UserRegisterRequest.dart';

class UserLoginUseCase extends StateNotifier<StateModel<UserOtpResponseModel?>> {
  final Ref ref;
  UserLoginUseCase(this.ref) : super(StateModel());

  void login(UserLoginRequest loginRequest) async {
    state = StateModel(state: DataState.LOADING);
    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginRequest.email ?? "", password: loginRequest.password ?? "");
      state = StateModel(state: DataState.SUCCESS , message: "success_login");
    }on FirebaseAuthException catch(e){
      print("Err ${e.code}");
      var message = "Something went wrong";
      if (e.code == 'user-not-found') {
        message = "user-not-found" ;
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        message = "INVALID_LOGIN_CREDENTIALS" ;
      }
      state = StateModel(state: DataState.ERROR , message: message);
    }
  }

  void logout() {
    prefs.remove('User');
    state = StateModel(
        state: DataState.SUCCESS, message: "log_out_success");
  }
}

class UserSignUpUseCase extends StateNotifier<StateModel<UserOtpResponseModel?>> {
  final Ref ref;
  
  var db = FirebaseFirestore.instance;

  UserSignUpUseCase(this.ref) : super(StateModel());

  void signUp(UserRegisterRequest userRegisterRequest) async {
    state = StateModel(state: DataState.LOADING);
    try{
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userRegisterRequest.email ?? "", password: userRegisterRequest.password ?? "");
      var doc = await db.collection("users").doc(user.user?.uid).set(userRegisterRequest.toJson(id: user.user?.uid));
      state = StateModel(state: DataState.SUCCESS , message: "success!");
    }on FirebaseAuthException catch(e){
      var message = "Something went wrong";
      if (e.code == 'email-already-in-use') {
        message = "email-already-in-use" ;
      } else if (e.code == 'invalid-email') {
        message = 'invalid-email';
      }
      state = StateModel(state: DataState.ERROR , message: message);
    }
  }

}

class UserDetailsUseCase extends StateNotifier<StateModel<appUser.User?>> {
  final Ref ref;
  
  var db = FirebaseFirestore.instance;

  UserDetailsUseCase(this.ref) : super(StateModel());

  void getDetails() async {
    state = StateModel(state: DataState.LOADING);
    try{
      if(FirebaseAuth.instance.currentUser != null){
        print("User ${FirebaseAuth.instance.currentUser?.uid}");
        var snapshot = await db.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();
        print("Data ${snapshot.exists}");
        appUser.User user = appUser.User.fromJson(snapshot.data());
        state = StateModel(state: DataState.SUCCESS , data: user , message: "success!");
      }

    }on FirebaseException catch(e){
      print("Err $e");
      var message = "Something went wrong";
      state = StateModel(state: DataState.ERROR , message: message);
    }
  }

}

class SetAttendanceUseCase extends StateNotifier<StateModel<bool>> {
  final Ref ref;
  
  var db = FirebaseFirestore.instance;

  SetAttendanceUseCase(this.ref) : super(StateModel());

  void setAttendance(data) async {
    state = StateModel(state: DataState.LOADING);
    try{
      var qrResult = jsonDecode(data.toString());
      if ((qrResult as Map<String,dynamic>).containsKey("student_name") && (qrResult).containsKey("student_id")){
        var currentUserId = FirebaseAuth.instance.currentUser?.uid;
        var studentId = qrResult["student_id"];
        String uuid = Uuid().v4();
        qrResult["attendance_date"] = Timestamp.now();
        qrResult["attendance_id"] = uuid;
        await db.collection("attendance").doc(currentUserId).collection("students").doc(uuid).set(qrResult);
        state = StateModel(state: DataState.SUCCESS , message: "success_attendance");
      }else{
        state = StateModel(state: DataState.ERROR , message: "not_match");
      }
    }catch(e){
      print("Err $e");
      var message = "something_wrong";
      state = StateModel(state: DataState.ERROR , message: message);
    }
  }

}

class GetAttendanceUseCase extends StateNotifier<StateModel<List<Student>>> {
  final Ref ref;
  
  var db = FirebaseFirestore.instance;
  List<Student> tempStudents = [];
  GetAttendanceUseCase(this.ref) : super(StateModel());

  void getAttendance({String? name,bool? orderByName , bool? isAscending = false,bool? isRefresh}) async {
    if(orderByName == null && isRefresh != true){
      state = StateModel(state: DataState.LOADING);
    }
    try{

      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      var ref = db.collection("attendance").doc(currentUserId).collection("students");

      QuerySnapshot<Map<String, dynamic>> snapshot;
      snapshot = await ref.orderBy(orderByName == true ? "student_name" : "attendance_date",descending: isAscending == false).get();

      List<Student> students = snapshot.docs.map((e) => Student.fromJson(e.data())).toList().where((element) => element.fullname?.startsWith(name??"") == true).toList();
      tempStudents = students;

      if(students.isEmpty){
        state = StateModel(state: DataState.EMPTY ,data : students, message: "success!");
      }else{
        state = StateModel(state: DataState.SUCCESS ,data : students, message: "success!");
      }

    }on FirebaseException catch(e){
      print("Err $e");
      var message =  "something_wrong";
      state = StateModel(state: DataState.ERROR , message: message);
    }
  }

  void searchStudents(name){
    if(tempStudents.where((element) => element.fullname?.startsWith(name) == true).toList().isEmpty){
      state = StateModel(state: DataState.EMPTY ,message: "success!");
    }else{
      state = StateModel(state: DataState.SUCCESS ,data : tempStudents.where((element) => element.fullname?.startsWith(name) == true).toList(), message: "success!");
    }
  }
}

class DeleteAttendanceUseCase extends StateNotifier<StateModel<bool>> {
  final Ref ref;
  
  var db = FirebaseFirestore.instance;

  DeleteAttendanceUseCase(this.ref) : super(StateModel());

  void deleteAttendance({List<String?>? attendanceIds}) async {
    try{
      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      WriteBatch batch = FirebaseFirestore.instance.batch();
      attendanceIds?.forEach((element) {
         var docRef = db.collection("attendance").doc(currentUserId).collection("students").doc(element);
        batch.delete(docRef);
      });
      await batch.commit();
      state = StateModel(state: DataState.SUCCESS , message: "delete_success");
      ref.read(getAttendanceNotifier.notifier).getAttendance();
    } on FirebaseException catch(e){
      var message = "something_wrong";
      state = StateModel(state: DataState.ERROR , message: message);
    }

  }

}

class BottomNavState extends StateNotifier<bool> {
  final Ref ref;
  BottomNavState(this.ref) : super(true);

  void setVisible(bool isVisible) async {
    state = isVisible;
  }

  void toggle() async {
    state = !state;
  }
}
