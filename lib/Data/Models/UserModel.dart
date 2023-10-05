
import 'User.dart';

class UserModel {
  final String? accessToken;
  final User? user;

  UserModel({this.accessToken, this.user,});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['token'],
      user: json['personal_information'] != null ? User.fromJson(json['personal_information']) : null,
    );
  }

  UserModel setNewUserData(User user) {
    return UserModel(accessToken: accessToken , user: user);
  }

  @override
  String toString() {
    return '${user} ${user?.email}  ${user?.id}';
  }

  Map toJson() {
    return {
      "token":accessToken,
      "personal_information": user?.toJson()
    };
  }
}
