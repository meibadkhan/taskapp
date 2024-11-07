import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:taskapp/app_service/api_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
 import '../app_models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  ApiService service = ApiService();

  File? file;
  List<TaskListData> taskData = [];
  List<TaskListData> filteredTaskData = [];



  checkInternet(context){
    final listener = InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
         getTask(context);

          break;
        case InternetStatus.disconnected:

          break;
      }
    });
  }
  /// Fetch task and store in both taskData and filteredTaskData
  ///********************************************* Getting data from Api *******************************************///

  Future<void> getTask(BuildContext context) async {
    try {


      final jsonString = await service.retrieveTask("03109598751", context);
      final task = Task.fromJson(jsonString);
      taskData = task.data;
      filteredTaskData = taskData;  // Initialize filtered list with all tasks
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  ///search task data
  void searchTask(String query) {
    if (query.isEmpty) {
      filteredTaskData = taskData; // Reset to all tasks if query is empty
    } else {
      filteredTaskData = taskData.where((task) {
        final taskNameLower = task.taskName.toLowerCase();
        final searchLower = query.toLowerCase();
        return taskNameLower.contains(searchLower);
      }).toList();
    }
    notifyListeners();
  }

  /// Default filter option
  String selectedFilter = 'By Date';

  ///Filter tasks by date
  void filterByDate() {
    selectedFilter = 'By Date';

    filteredTaskData.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  /// Filter tasks by alphabetical order of task name
  void filterByName() {
    selectedFilter = 'By Name';

    filteredTaskData.sort((a, b) => a.taskName.toLowerCase().compareTo(b.taskName.toLowerCase()));
    notifyListeners();
  }

  ///update the task status to complete
  ///********************************************* Update Status Api *******************************************///

  updateTask(taskId,context)async{
    final result = await service.updateStatus(taskId, true, context);
    if(result!=null){
      showInfo(result['message'], Colors.green);
      getTask(context);
    }

  }
  ///Delete the task from api
  ///********************************************* Delete  Task *******************************************///

deleteTask(taskId,context)async{
    final result = await service.deleteTask(taskId, context);

    if(result!=null){
      showInfo(result['message'], Colors.red);

      getTask(context);
    }

}
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescriptions = TextEditingController();


///Upload task to api
  ///********************************************* Upload Task  *******************************************///

  uploadTask(context)async{
  final result = await service.storeTask(taskName.text.toString(), taskDescriptions.text.toString(), file!, context);


 if(result !=null && result.toString().contains("error")){
   showInfo(result['error'],Colors.red);
 }
 if(result!=null && result.toString().contains("message")){
   getTask(context);
   showInfo(result['message'],Colors.green);
 }


}

  ///********************************************* show info message  *******************************************///

showInfo(msg,color){
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:color,
      textColor: Colors.white,
      fontSize: 16.0
  );

}

  ///********************************************* pick image   *******************************************///

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,  // Change to ImageSource.camera for using the camera
      imageQuality: 80,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }


  }


  ///********************************************* show loader   *******************************************///

  showLoader(context){
  showDialog(

      context: context,
      barrierDismissible: false,
      builder: (context){
    return const AlertDialog(

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator(),),
          Text("Please Wait....")
        ],
      ),
    );
  });
  }


  ///update the ui
  updateState(){
    notifyListeners();
  }
}