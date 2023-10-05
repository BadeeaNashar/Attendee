class UserRegisterRequest {
  final String? email;
  final String? fullname;
  final String? password;
  final String? phone;
  final String? college_name;

  UserRegisterRequest(this.email,this.fullname, this.password, this.college_name,this.phone);

  @override
  String toString() {
    return '$email $fullname $password $college_name';
  }

  Map<String,dynamic> toJson({String? id}) {
    return {
      "email":email,
      "fullname": fullname,
      "phone": phone,
      "college_name": college_name,
      "id": id,
    };
  }
}
