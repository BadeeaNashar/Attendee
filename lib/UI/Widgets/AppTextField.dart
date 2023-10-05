import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef StringCallBack = Function(String);

class AppTextField extends StatefulWidget {
  final String hint;
  final String label;
  final StringCallBack? value;
  final StringCallBack? changeValueCallback;
  final TextEditingController textEditingController;
  final double? width;
  final BorderRadius? borderRidus;
  final Color? textFieldColor;
  final Color? textFieldBorderColor;
  final TextInputType? textInputType;
  final bool? secured;
  final int? minLines;
  final int? maxLines;
  final int? maxLen;
  final bool? disabled;
  final VoidCallback? onClick;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final String? endText;
  final String? Function(String?)? validate;
  final Widget? endIcon;
  final TextInputFormatter? mask;
  AppTextField(
      {Key? key,
      required this.hint,
      this.borderRidus,
      this.secured = false,
      this.textInputType,
      this.width,
      required this.label,
      this.value,
      this.style,
      this.minLines,
      this.maxLines,
      this.maxLen,
        this.endIcon,
      this.changeValueCallback,
      this.mask,
      required this.textEditingController,
      this.textFieldColor, this.textInputAction, this.textFieldBorderColor, this.disabled, this.onClick, this.endText, this.validate})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _visiblePassword = false;


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: widget.width,
        child:TextFormField(
            inputFormatters: widget.mask != null ? [widget.mask!] : null,
            onTapOutside: (val){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            textAlign: widget.maxLen != null ? TextAlign.center : TextAlign.start,
            obscureText: (!_visiblePassword && widget.secured!),
            onChanged: (val) {
              if(widget.changeValueCallback != null){
                widget.changeValueCallback!(val);
              }
            },
            validator: widget.validate,
            minLines: widget.minLines,
            maxLength: widget.maxLen,
            maxLines: widget.secured == true ? 1 : widget.maxLines,
            onFieldSubmitted: (val) =>  widget.value!(val),
            style: widget.style ?? TextStyle(color: Theme.of(context).textTheme.bodyText1!.color,fontSize: 16),
            decoration: InputDecoration(
                suffixText: widget.endText,
                labelText: widget.label,
                hintText: widget.hint,
                suffixIcon: widget.secured!
                    ? IconButton(
                  onPressed: () => setState(() => _visiblePassword = !_visiblePassword),
                  icon: Icon(_visiblePassword ? Icons.visibility_off : Icons.visibility),color: Colors.grey,)
                    : widget.endIcon,
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Theme.of(context).textTheme.bodyText1!.color),
                focusedBorder: getBorder,
                errorBorder: getErrBorder,
                focusedErrorBorder: getErrBorder,
                enabledBorder: getBorder,
                disabledBorder: getBorder,
                filled: true,

                enabled: widget.disabled != null ? (!widget.disabled!) : true,
                fillColor: widget.textFieldColor??themeData.appBarTheme.backgroundColor)),
      ),
    );
  }

  InputBorder get getBorder => widget.textFieldBorderColor != null ?  OutlineInputBorder(
    borderSide: BorderSide(color: widget.textFieldBorderColor??Colors.transparent),
    borderRadius: widget.borderRidus?? BorderRadius.circular(10),
  ) : UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.transparent),
    borderRadius: widget.borderRidus?? BorderRadius.circular(10),
  );

  InputBorder get getErrBorder => widget.textFieldBorderColor != null ?  OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: widget.borderRidus?? BorderRadius.circular(10),
  ) : UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.transparent),
    borderRadius: widget.borderRidus?? BorderRadius.circular(10),
  );
}
