import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/screens/add_task.dart';
import 'package:to_do_algoriza/presentation/screens/all_tasks.dart';
import 'package:to_do_algoriza/presentation/layouts/board_screen.dart';
import 'package:to_do_algoriza/presentation/screens/schedule_screen.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return  MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.myWhite,
              appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.myWhite,
                  elevation: 1.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: AppColors.myWhite,
                  ),
                  iconTheme: IconThemeData(
                      color: AppColors.myBlack
                  )
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: BoardScreen(),
          );
        },
      ),

    );
  }
}


