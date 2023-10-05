import '../../../../../UI/Widgets/AppTextField.dart';

class ValidationUtils {

  static String? Function(String?)? required(message){
    return (val) => val?.isEmpty == true ? message : null;
  }

  static String? passwordMatch(nVal,otherPassword,message){
    if(nVal != otherPassword) return message;
    return null;
  }
}