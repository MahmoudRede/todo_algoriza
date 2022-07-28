import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/screens/add_task.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/widgets/button_manager.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class CompletedTasks extends StatelessWidget {
  CompletedTasks({Key? key}) : super(key: key);
  // bool checkValue=false;
  // List<bool> boolValues= List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(listener: (context,state){

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
                                  activeColor: Color(cubit.completed[index]['color']),
                                  side: BorderSide(color: Color(cubit.completed[index]['color']),width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  value: true,
                                  onChanged: (value){
                                      // boolValues[index]=value!;
                                      cubit.updateDatabase(S: 'unComplete', id: cubit.completed[index]['id']);

                                  }),
                              Text(cubit.completed[index]['title'],style: textStyle(AppColors.myBlack, 15, FontWeight.w400),)
                            ],
                          );
                        },
                        separatorBuilder: (context,index){
                          return const SizedBox(height: 10,);
                        },
                        itemCount: cubit.completed.length
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
