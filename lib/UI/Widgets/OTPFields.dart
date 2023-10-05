import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../Utils/Extintions.dart';
import '../Theme/AppColors.dart';
import 'AppTextField.dart';

class OTPFields extends StatefulWidget {
  const OTPFields({Key? key}) : super(key: key);

  @override
  State<OTPFields> createState() => OTPFieldsState();
}

class OTPFieldsState extends State<OTPFields> {

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();


  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode fourthFocusNode;

  @override
  void initState() {
    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp1,
                focusNode: firstFocusNode,
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.displayLarge,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(secondFocusNode);
                  }
                },
                decoration: InputDecoration(
                  counter: const SizedBox(),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.mainAppColorLight),
                    borderRadius:BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp2,
                focusNode: secondFocusNode,
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.displayLarge,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(thirdFocusNode);
                  }else{
                    FocusScope.of(context).requestFocus(firstFocusNode);
                  }
                },
                decoration: InputDecoration(
                  counter: const SizedBox(),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.mainAppColorLight),
                    borderRadius:BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp3,
                focusNode: thirdFocusNode,
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.displayLarge,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(fourthFocusNode);
                  }else{
                    FocusScope.of(context).requestFocus(secondFocusNode);
                  }
                },
                decoration: InputDecoration(
                  counter: const SizedBox(),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.mainAppColorLight),
                    borderRadius:BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp4,
                focusNode: fourthFocusNode,
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.displayLarge,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).requestFocus(thirdFocusNode);
                  }
                },
                decoration: InputDecoration(
                  counter: const SizedBox(),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.mainAppColorLight),
                    borderRadius:BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var element in [otp1,otp2,otp3,otp4]) {
      element.dispose();
    }

    super.dispose();
  }

  String get getCode => [otp1,otp2,otp3,otp4].map((e) => e.text).join("");

  void setCode (String code){
    otp1.text = code[0];
    otp2.text = code[1];
    otp3.text = code[2];
    otp4.text = code[3];
  }
}
