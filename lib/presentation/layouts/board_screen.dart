import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/data/local/notification_helper.dart';
import 'package:to_do_algoriza/presentation/screens/add_task.dart';
import 'package:to_do_algoriza/presentation/screens/all_tasks.dart';
import 'package:to_do_algoriza/presentation/screens/completed_tasks.dart';
import 'package:to_do_algoriza/presentation/screens/favorite_tasks.dart';
import 'package:to_do_algoriza/presentation/screens/schedule_screen.dart';
import 'package:to_do_algoriza/presentation/screens/uncompleted_tasks.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/styles/icon_broken.dart';
import 'package:to_do_algoriza/presentation/widgets/button_manager.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key}) : super(key: key);


  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {

  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 4,
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=TodoCubit.get(context);
          return  Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text('Board',
                            style: textStyle(
                                AppColors.myBlack,
                                20,
                                FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: (){
                              cubit.getDatabase(cubit.database);
                              Navigator.push(context, MaterialPageRoute(builder: (_){
                                return ScheduleScreen();
                              }));

                            },
                            icon: const Icon(IconBroken.Category,)
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: AppColors.myGreyLight,
                    )
                  ],
                ),
                bottom: TabBar(
                  labelPadding: const EdgeInsets.all(3),
                  indicatorColor: AppColors.myBlack,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(color: Colors.red,fontSize: 10),
                  unselectedLabelColor: AppColors.myGrey,
                  labelColor: AppColors.myBlack,
                  tabs: [

                    Tab(child: Text('All',style: GoogleFonts.roboto(fontSize: 13),)),
                    Tab(child: Text('Completed',style:  GoogleFonts.roboto(fontSize: 11),)),
                    Tab(child: Text('UnCompleted',style:  GoogleFonts.roboto(fontSize: 11),)),
                    Tab(child: Text('Favorite',style:  GoogleFonts.roboto(fontSize: 12),)),

                  ],
                ),

              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        const AllTasks(),
                        CompletedTasks(),
                        const UncompletedTasks(),
                        FavoriteTasks(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25
                    ),
                    child: ButtonManager(title: 'Add a task', function: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return const AddTask();
                      }));
                    }),
                  ),
                ],
              )

          );
        },
      )
    );
  }
}
