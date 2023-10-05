
class UserLoginRequest {
  final String? email;
  final String? password;

  UserLoginRequest(this.email,this.password,);

  @override
  String toString() {
    return '$email $password';
  }

  Map toJson() {
    return {
      "email":email,
      "password": password,
    };
  }
}
