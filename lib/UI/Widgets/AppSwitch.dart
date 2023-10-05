import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AppSwitch extends StatefulWidget {
  final String? title;
  final bool? adaptive;
  final TextStyle? textStyle;
  final Function(bool) onChanged;
  const AppSwitch({Key? key, this.title, this.adaptive, this.textStyle,required this.onChanged}) : super(key: key);
  @override
  _AppSwitchState createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  var _checked = false;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){setState(()=> _checked = !_checked);},
      title: widget.title != null ? Text(widget.title??"",style: widget.textStyle) : null,
      trailing: SizedBox(
        child: FittedBox(child: CupertinoSwitch(value: _checked, onChanged: (val){
          setState(() {
            _checked = val;
          });
          widget.onChanged(_checked);
        },)),
        width: 40,
        height: 40,
      ),
    );
  }
}
