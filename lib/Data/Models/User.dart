import '../../ApiRouts.dart';

class User {
  User({
      this.id,
      this.fullname,
      this.email, 
      this.photo,
      this.college,
      this.phone,
      });

  User.fromJson(dynamic json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    college = json['college_name'];
  }

  User.copyWith({
    int? id,
    String? fullname,
    String? email,
    String? photo,}) {
    this.fullname = fullname??this.fullname;
    this.email = email??this.email;
    this.photo = photo??this.photo;
  }

  String? id;
  String? fullname;
  String? email;
  String? photo;
  String? college;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullname'] = fullname;
    map['email'] = email;
    map['photo'] = photo;
    map['photo'] = college;
    map['photo'] = phone;
    return map;
  }

  @override
  String toString() {
    return "$id $fullname }";
  }

  String? get getFullPathImg => photo != null ? mainAppUrlDomain + (photo ?? "") : null;
}