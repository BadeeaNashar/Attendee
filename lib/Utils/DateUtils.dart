import '../../../../../UI/Theme/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef  OnDateValue = Function(DateTime?);

Future<DateTime> selectDate(BuildContext context,
    {DateTime? withInitialDate}) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: withInitialDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null && picked != DateTime.now()) return picked;
  return DateTime.now();
}

void showModalDatePicker(
    BuildContext context, CupertinoDatePickerMode mode, double height, {required OnDateValue? onDateValue}) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        DateTime dateTime = DateTime.now();
        return Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                  child: CupertinoDatePicker(
                    mode: mode,
                    onDateTimeChanged: (value) {
                      dateTime = value;
                    },
                    initialDateTime: DateTime.now(),
                    minimumYear: 1980,
                    maximumYear: 2050,
                  ),
                ),
              ),
              SizedBox(child: MaterialButton(onPressed: (){
                Navigator.pop(context);
                onDateValue!(dateTime);
              },child: Text("Confirm",style: TextStyle(color: AppColors.appSwatch),)),width: MediaQuery.of(context).size.width * 0.9,)
            ],
          ),
        );
      });
}

class DateUtilsClass {

  static String convertTimeStringToDayTime(String time){
    return DateFormat('hh a').format(DateFormat("hh:mm:ss").parse(time));
  }

  static String convertFormatFromTo(String from,String to,String dateTime){
    return DateFormat(to).format(DateFormat(from).parse(dateTime));
  }
}