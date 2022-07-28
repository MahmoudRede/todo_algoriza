import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/screens/add_task.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/widgets/button_manager.dart';
import 'package:to_do_algoriza/presentation/widgets/generate_color.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

final _random = Random();

class AllTasks extends StatefulWidget {

  const AllTasks({Key? key}) : super(key: key);

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  bool checkValue=false;
  List<bool> boolValues= List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){

       },
       builder: (context,state){
          var cubit=TodoCubit.get(context);
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Expanded(
                      child:ListView.separated(
                          itemBuilder: (context,index){
                            return Row(
                              children: [
                                Checkbox(
                                    activeColor: Color(cubit.allTasks[index]['color']),
                                    side: BorderSide(color: Color(cubit.allTasks[index]['color']),width: 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    value: cubit.allTasks[index]['state']=='completed'? true :false,
                                    onChanged: (value){
                                      setState((){
                                        boolValues[index]=value!;

                                      });
                                      if(cubit.allTasks[index]['state']=='completed'){
                                        cubit.updateDatabase(S: 'unComplete', id: cubit.allTasks[index]['id']);
                                      }
                                      else
                                      {
                                        cubit.updateDatabase(S: 'completed', id: cubit.allTasks[index]['id']);
                                      }
                                    }),
                                Text(cubit.allTasks[index]['title'],style: textStyle(AppColors.myBlack, 15, FontWeight.w400),),
                                const Spacer(),
                                PopupMenuButton(
                                    itemBuilder: (context) => [

                                      PopupMenuItem(
                                        value: 1,
                                        child:  Text("Completed",style: textStyle(
                                            AppColors.primaryColor,
                                            15,
                                            FontWeight.w400
                                        )
                                        ),
                                        onTap: (){
                                          cubit.updateDatabase(S: 'completed', id: cubit.allTasks[index]['id']);
                                        },
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Text("Uncompleted",style: textStyle(
                                            AppColors.primaryColor,
                                            15,
                                            FontWeight.w400
                                        )),
                                        onTap: (){
                                          cubit.updateDatabase(S: 'unComplete', id: cubit.allTasks[index]['id']);
                                        },
                                      ),
                                       PopupMenuItem(
                                        value: 3,
                                        child: Text("Favorite",style: textStyle(
                                            AppColors.primaryColor,
                                            15,
                                            FontWeight.w400
                                        )),
                                         onTap: (){
                                          cubit.updateFavorite(F: 'yes', id: cubit.allTasks[index]['id']);

                                         },
                                      ),
                                       PopupMenuItem(
                                          value: 4,
                                          child:  Text("Delete",style: textStyle(
                                              AppColors.primaryColor,
                                              15,
                                              FontWeight.w400
                                          )
                                          ),
                                          onTap: (){
                                            cubit.deleteDatabase(id: cubit.allTasks[index]['id']);
                                          },
                                      ),
                                    ]
                                )

                              ],
                            );
                          },
                          separatorBuilder: (context,index){
                            return const SizedBox(height: 10,);
                          },
                          itemCount: cubit.allTasks.length
                      ),
                    ),

                  ],
                ),
              )
          );
       },

    );
  }
}
