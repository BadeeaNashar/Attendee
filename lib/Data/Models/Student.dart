import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  Student({
    this.id,
    this.attendanceId,
    this.fullname,
    this.grade,
    this.student_major,
    this.phone,
    this.attendance_date
  });
  
  Student.fromJson(dynamic json) {
    id = json['student_id'];
    attendanceId = json['attendance_id'];
    fullname = json['student_name'];
    grade = json['grade'];
    phone = json['student_phone'];
    student_major = json['student_major'];
    attendance_date = json['attendance_date'];
  }

  Student.copyWith({
    int? id,
    String? fullname,
    String? email,
    String? photo,}) {
    this.fullname = fullname??this.fullname;
  }

  String? id;
  String? fullname;
  String? grade;
  String? student_major;
  String? phone;
  String? attendanceId;

  Timestamp? attendance_date;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['student_name'] = fullname;
    map['grade'] = grade;
    map['student_major'] = student_major;
    map['phone'] = phone;
    return map;
  }

  @override
  String toString() {
    return "$id $fullname }";
  }
}