import '../../../../../UI/Theme/AppColors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? enabled;
  final VoidCallback onPress;
  final String? text;
  final Widget? child;
  final Color? backColor;
  final bool? outlined;
  final double? strokeWidth;
  final BorderRadiusDirectional? radius;
  final bool? isCircle;
  final double? elevation;
  const AppButton({Key? key, this.enabled = true, required this.onPress,this.backColor,this.text,this.child,this.width,this.height, this.radius, this.outlined, this.strokeWidth,this.isCircle,this.elevation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FadeTransition(
        opacity: enabled! ? const AlwaysStoppedAnimation(1.0) : const AlwaysStoppedAnimation(0.5),
        child: outlined == true ? OutlinedButton(
          onPressed: enabled! ? onPress : null,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: backColor??AppColors.appSwatch,width: strokeWidth??1),
            shape: RoundedRectangleBorder(borderRadius: radius??BorderRadius.circular(10),)
          ),
          child: child?? Text(
              text!,
              style: TextStyle(color: outlined == true ? backColor : Colors.white, fontSize: 14)),
        ) : ElevatedButton(
          onPressed: enabled! ? onPress : null,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(elevation??0.0),
            shape: isCircle == true ? MaterialStateProperty.all(const CircleBorder()) : MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: radius??BorderRadius.circular(10)
            )),
            backgroundColor: MaterialStateProperty.all(backColor ?? AppColors.appSwatch),
          ),
          child: child ?? Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ),
    );
  }
}
