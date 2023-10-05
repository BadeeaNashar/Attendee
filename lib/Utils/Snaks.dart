import 'package:flutter/material.dart';
import '../UI/Theme/AppColors.dart';

class SnakeBar {
  static showSnakeBar(context,{required bool isSuccess,required String message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(padding: const EdgeInsets.all(20),behavior:SnackBarBehavior.floating,content: Text(message,style: const TextStyle(color: Colors.white),),backgroundColor: isSuccess ? AppColors.greenColor : AppColors.redColor,));
  }

  static showColoredSnakeBar(context,{Color? color,Widget? widget,required String message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(widget != null) widget,
        Text(message,style: const TextStyle(color: Colors.white),)
      ],
    ),backgroundColor: color?? AppColors.greenColor ));
  }
}
