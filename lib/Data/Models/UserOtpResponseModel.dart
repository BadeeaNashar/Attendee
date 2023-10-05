class UserOtpResponseModel {
  UserOtpResponseModel({
      this.code,
      this.userId,
  });

  UserOtpResponseModel.fromJson(dynamic json) {
    code = json['id'];
    userId = json['user_id'];
  }
  int? userId;
  String? code;

}