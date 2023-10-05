import 'package:Attendee/Data/Models/Student.dart';
import 'package:Attendee/UI/Theme/AppColors.dart';
import 'package:Attendee/UI/Widgets/FlatAppButton.dart';
import 'package:Attendee/Utils/Extintions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Data/Providers/UserProvider.dart';
import '../Dialogs/LoadingDialog.dart';
import 'dart:ui' as ui;
class StudentsTable extends ConsumerStatefulWidget {
  final bool isDeleteMode;
  final Function(List<String>?)? onSelectionChange;
  const StudentsTable({super.key,required this.isDeleteMode,this.onSelectionChange});

  @override
  ConsumerState<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends ConsumerState<StudentsTable> {

  List<List<Student>> _students = [];
  List<int> selectedStudents = [];
  int _currentSortColumn = 0;
  bool _isSortAsc = true;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final studentsState = ref.watch(getAttendanceNotifier);
    _students = studentsState.data?.slices(8).toList() ?? [];
    ref.listen(getAttendanceNotifier, (previous, next) {
      currentPage = 0;
    });
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: CheckboxTheme(data: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(AppColors.mainAppColorLight),
        checkColor: MaterialStateProperty.all(Colors.white),
      ), child: Card(
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: context.getScreenSize.width,
                child: DataTable(
                  columns: _createColumns(fakeHeader: true),
                  rows: _createRows(),
                  columnSpacing: 0,
                  showCheckboxColumn: widget.isDeleteMode,
                ),
              ),
            ),
            SizedBox(
              width: context.getScreenSize.width,
              child: DataTable(
                columns: _createColumns(),
                headingRowColor: MaterialStateProperty.all(Colors.white),
                rows:[],
                sortColumnIndex: _currentSortColumn,
                sortAscending: _isSortAsc,
                columnSpacing: 0,
                showCheckboxColumn: widget.isDeleteMode,
              ),
            ),
          ],
        )
      )),
    );
  }

  List<DataColumn> _createColumns({bool? fakeHeader = false}) {
    return [
      DataColumn(
        label: Expanded(child: Opacity(opacity: fakeHeader == true ? 0 : 1 , child: const Text('اسم الطالبة',style: TextStyle(fontWeight: FontWeight.w600)))),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            ref.read(getAttendanceNotifier.notifier).getAttendance(orderByName: true,isAscending: _isSortAsc);
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(label: Expanded(child: Opacity(opacity: fakeHeader == true ? 0 : 1 , child: Text('تاريخ و وقت الحضور',style: TextStyle(fontWeight: FontWeight.w600),),)),onSort: (columnIndex, _) {
        setState(() {
          _currentSortColumn = columnIndex;
          ref.read(getAttendanceNotifier.notifier).getAttendance(orderByName: false,isAscending: _isSortAsc);
          _isSortAsc = !_isSortAsc;
        });
      },),
      DataColumn(label: Expanded(
        child: Opacity(
          opacity: fakeHeader == true ? 0 : 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(child: Icon(Icons.arrow_back_ios_rounded,size: 12,color: !(currentPage < _students.length - 1) ? Colors.grey : Colors.black,) , onTap: (){
                setState(() {
                  if(currentPage < _students.length - 1){
                    currentPage = currentPage + 1;
                  }
                });
              },),
              Text(" ${currentPage + 1} ",style: TextStyle(fontSize: 12),),
              GestureDetector(child: Icon(Icons.arrow_forward_ios,size: 12,color : !(currentPage > 0) ? Colors.grey : Colors.black,),onTap: (){
                if(currentPage > 0){
                  setState(() {
                    currentPage = currentPage - 1;
                  });
                }
              },)
            ],),
        ),
      ))
    ];
  }

  List<DataRow> _createRows() {
    return _students[currentPage].mapIndexed((index,student) {
      return  DataRow(
          onSelectChanged:(pos){
            setState(() {
              if(pos == true){
                selectedStudents.add(index);
              }else{
                selectedStudents.remove(index);
              }
            });
            widget.onSelectionChange?.call(selectedStudents.map((e) => _students[currentPage][e].attendanceId??"").toList());
          },
          selected: selectedStudents.contains(index),
          cells: [
            DataCell(Text(student.fullname.toString(),style: const TextStyle(fontSize: 14),),onTap: (){
              showStudent(student: student);
            }),
            DataCell(Text(DateFormat("dd/MM/yyyy hh:mm:ss a").format(student.attendance_date!.toDate()),style: const TextStyle(fontSize: 12),)),
            const DataCell(SizedBox())
          ]);
    }).toList();
  }

  showStudent({required Student student}) async {
    showAppDialog(context , Dialog(
      insetPadding: const EdgeInsets.all(14),
      backgroundColor:  Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child:  Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                student.fullname ?? "",
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.titleLarge?.copyWith(color: AppColors.mainAppColorDark,fontSize: 24),
              ),
            ),
            if(student.student_major != null )Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                student.student_major ?? "",
                textAlign: TextAlign.center,
                style: context.appTheme.textTheme.titleMedium?.copyWith(color: AppColors.mainAppColorDark,fontSize: 16),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school,size: 16,color: Colors.grey,),
                  const SizedBox(width: 9,),
                  Text(
                    student.grade ?? "",
                    textAlign: TextAlign.center,
                    style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_rounded,size: 16,color: Colors.grey,),
                  const SizedBox(width: 9,),
                  Text(
                    student.id ?? "",
                    textAlign: TextAlign.center,
                    style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone,size: 16,color: Colors.grey,),
                  const SizedBox(width: 9,),
                  GestureDetector(
                    onTap: (){
                      launchUrl(Uri.parse("tel:=${student.phone ?? ""}"));
                    },
                    child: Text(
                      student.phone ?? "",
                      textAlign: TextAlign.center,
                      style: context.appTheme.textTheme.titleMedium?.copyWith(color:Colors.grey,fontSize: 16,decoration:TextDecoration.underline,),
                      textDirection: ui.TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            FlatAppButton(onPress: ()=> context.pop() , text: 'الغاء',txtColor: AppColors.mainAppColorLight, ),

          ],
        ),
      ),
    ),);
  }
}
