import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
 import 'package:taskapp/app_providers/task_provider.dart';
import 'app_screens/home_screens/home_screen.dart';
main(){
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiProvider(
      providers: [
         ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
      ],
      child: ResponsiveSizer(
          builder: (context, orientation, screentype) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffF2F5FF)
          ),
          title: "Task App",
          home:   HomeScreen(),
        );
        }
      ),
    );
  }
}

