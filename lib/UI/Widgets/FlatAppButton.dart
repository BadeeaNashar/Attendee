import '../../../../../UI/Theme/AppColors.dart';
import 'package:flutter/material.dart';

class FlatAppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? enabled;
  final VoidCallback onPress;
  final String? text;
  final Widget? child;
  final Color? txtColor;
  const FlatAppButton({Key? key, this.enabled = true, required this.onPress,this.txtColor,this.text,this.child,this.width,this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FadeTransition(
        opacity: enabled! ? AlwaysStoppedAnimation(1.0) : AlwaysStoppedAnimation(0.5),
        child: TextButton(
          onPressed: enabled! ? onPress : null,
          child: child ?? Text(
              text??"",
              style: TextStyle(color: txtColor??Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
