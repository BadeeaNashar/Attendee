import 'package:Attendee/Data/Models/StateModel.dart';
import 'package:Attendee/UI/Widgets/AppButton.dart';
import 'package:Attendee/UI/Widgets/AppTextField.dart';
import 'package:Attendee/UI/Widgets/FlatAppButton.dart';
import 'package:Attendee/Utils/Debouncer.dart';
import 'package:Attendee/Utils/Extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Data/Providers/UserProvider.dart';
import '../../../Utils/Snaks.dart';
import '../../Widgets/StudentsTable.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> with WidgetsBindingObserver {
  late Debounce debounce;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getAttendanceNotifier.notifier).getAttendance();
    });

    WidgetsBinding.instance.addObserver(this);


    debounce = Debounce(milliseconds: 600);
    super.initState();
  }
  bool _isDeleteMode = false;
  List<String?> toBeDeleted = [];
  @override
  Widget build(BuildContext context) {
    final studentsState = ref.watch(getAttendanceNotifier);

    ref.listen(deleteAttendanceNotifier, (previous, next) {
      next.handelStateWithoutWidget(
          onLoading: (state){},
          onFailure: (state){
            SnakeBar.showSnakeBar(context, isSuccess: false, message: context.getLocaleString(next.message ?? ""));
          },
          onSuccess: (state){
            SnakeBar.showSnakeBar(context, isSuccess: true, message: context.getLocaleString(next.message ?? ""));
          }
      );
    });

    return studentsState.handelState(
      onLoading: (state) => const Center(child: CircularProgressIndicator(),),
      onFailure: (state) => Column(
        children: [
          searchSection(),
          const Expanded(child: Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Center(child: Text("لا يوجد حضور"),),
          )),
        ],
      ),
      onSuccess: (state) => Column(
        children: [
          const SizedBox(height: 2,),
          searchSection(),
          // ignore: prefer_const_constructors
          Expanded(
              child:StudentsTable(isDeleteMode: _isDeleteMode,onSelectionChange: (data){
                toBeDeleted = data??[];
              },)
          ),
          if(_isDeleteMode) Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppButton(onPress: (){
              ref.read(deleteAttendanceNotifier.notifier).deleteAttendance(attendanceIds: toBeDeleted);
            },height: 50,width: context.getScreenSize.width,text: "حذف",),
          ),
          const SizedBox(height: 100,)
        ],
      )
    );
  }

  Widget searchSection(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: AppTextField(hint: 'بحث', label: 'بحث', textEditingController: textEditingController,endIcon: const Icon(Icons.search),changeValueCallback: (val){
            ref.read(getAttendanceNotifier.notifier).searchStudents(val);
          },)),
          const SizedBox(width: 10,),
          AppButton(
            elevation: 0,
            backColor: Colors.white,
            height: 70,
            onPress: (){
              setState(() {
                _isDeleteMode = !_isDeleteMode;
              });
            },child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isDeleteMode ? "الغاء" : "حذف",
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16),
              ),
              const SizedBox(width: 9,),
              FaIcon(_isDeleteMode ? FontAwesomeIcons.close  : FontAwesomeIcons.trashCan,size: 16,color: Colors.grey,),
            ],
          ),)
        ],
      ),
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //ref.read(getAttendanceNotifier.notifier).getAttendance();
    }
  }

}
