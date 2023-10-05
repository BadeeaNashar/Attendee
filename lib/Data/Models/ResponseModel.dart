import '../../../../../Data/Models/StateModel.dart';

class ResponseModel {
  ResponseState? responseState;
  bool? isSuccess;
  String? message;
  List? errors;
  dynamic data;
  int? userId;

  ResponseModel({this.responseState = ResponseState.Initial,this.isSuccess = false,this.message = "",this.data,this.errors,this.userId});

  factory ResponseModel.fromJson(dynamic map) {
    return ResponseModel(
      isSuccess: map['status']!= null ? ((map['status'] as String == "success")) : false,
      message : ( map['message'] != null &&  map['message'] is String) ? map['message'] as String : ( map['message'] != null &&  map['message'] is String) ? map['message'] as String : null,
      data : map['data'] ?? map,
      errors: map['data'] is List ? map["data"] : null,
      userId: (map as Map).containsKey("user_id") ? map["user_id"] : null,
    );
  }

  @override
  String toString() {
    return '{${this.isSuccess} , ${this.message} ${this.responseState}';
  }

  String? getFullError() {

    String err = errors?.map((errorValue) => errorValue).join("\n") ?? "Something Wrong !";
    print("Full Er $err");
    return err;
  }
  StateModel toState(data){
    return StateModel(state: isSuccess == true ? DataState.SUCCESS : DataState.ERROR , message: message , data: data);
  }
}

enum ResponseState {
  Initial,
  Loading,
  Loaded,
  Error
}