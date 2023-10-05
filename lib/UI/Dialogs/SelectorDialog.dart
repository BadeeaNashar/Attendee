import 'package:animations/animations.dart';
import '../../../../../UI/Widgets/AppButton.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../Utils/Extintions.dart';
const double _kItemExtent = 32.0;

class SelectorDialog {
  static void showDialog(BuildContext context,List<String> items,Function(int) onSelectChange,{String? header}) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: _DialogBody(items: items,header: header,onSelectChange: onSelectChange),
          ),
        ));
  }

  static void showPopUpDialog(BuildContext context,List<String> items,Function(int) onSelectChange,{String? header,Function(int)? onSelectConfirm,}) async {
    await showModal(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
            barrierDismissible: false,

            transitionDuration: Duration(milliseconds: 500)),
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.getScreenSize.height * 0.1 , horizontal: 20.0),
                child: _DialogBody(items: items,header: header,withConfirm : onSelectConfirm,onSelectChange: onSelectChange),
              ),
            ),
        );
  }
}

class _DialogBody extends StatelessWidget {

  final String? header;
  final List<String> items;
  final Function(int) onSelectChange;
  final Function(int)? withConfirm;
  _DialogBody({Key? key, this.header, required this.items,this.withConfirm,required this.onSelectChange}) : super(key: key);

  var selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.backgroundColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          if(header != null) Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(header!,style: context.appTheme.textTheme.bodyText2,),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1,
              useMagnifier: true,
              backgroundColor: context.appTheme.backgroundColor,
              itemExtent: _kItemExtent,
              onSelectedItemChanged: (int selectedItem) {
                selected = selectedItem;
                onSelectChange(selectedItem);
              },
              children:
              List<Widget>.generate(items.length, (int index) {
                return Center(
                  child: Text(
                    items[index],
                  ),
                );
              }),
            ),
          ),),
          if(withConfirm != null) Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppButton(onPress: (){
              withConfirm?.call(selected);
            },text: context.getLocaleString('confirm'),width: context.getScreenSize.width * 0.8,height: 50,),
          )
        ],
      ),
    );
  }
}
