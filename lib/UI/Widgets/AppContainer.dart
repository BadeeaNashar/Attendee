import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onClick;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? borderColor;
  const AppContainer({Key? key,required this.child,this.color,this.borderRadius,this.onClick,this.padding,this.margin,this
  .borderColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin:  margin??EdgeInsets.symmetric(vertical: 10),
      padding: padding??EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: borderRadius??BorderRadius.circular(10),
          color: color != null ? color : themeData.backgroundColor,
          border: borderColor != null ? Border.all(color: borderColor!,width: 1.5) : null,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1),blurRadius: 15)]
      ),
      child: ClipRRect(
        borderRadius: borderRadius??BorderRadius.circular(10),
        child: Material(
          color: color != null ? color : themeData.backgroundColor,
          child: InkWell(
            onTap: onClick != null ? onClick : null,
            child: child,
          ),
        ),
      ),
    );
  }
}
