import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/screens/add_task.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/styles/icon_broken.dart';
import 'package:to_do_algoriza/presentation/widgets/button_manager.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class FavoriteTasks extends StatefulWidget {
  FavoriteTasks({Key? key}) : super(key: key);

  @override
  State<FavoriteTasks> createState() => _FavoriteTasksState();
}

class _FavoriteTasksState extends State<FavoriteTasks> {
  bool checkValue=false;

  List<bool> boolValues= List.generate(15, (index) => false);

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
                                  activeColor: Color(cubit.favorite[index]['color']),
                                  side: BorderSide(color: Color(cubit.favorite[index]['color']),width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),

                                  value: cubit.favorite[index]['state']=='completed'? true :false,
                                  onChanged: (value){
                                    setState((){
                                      boolValues[index]=value!;

                                    });
                                    if(cubit.favorite[index]['state']=='completed'){
                                      cubit.updateDatabase(S: 'unComplete', id: cubit.favorite[index]['id']);
                                    }
                                    else
                                    {
                                      cubit.updateDatabase(S: 'completed', id: cubit.favorite[index]['id']);
                                    }
                                  }),
                              Text(cubit.favorite[index]['title'],style: textStyle(AppColors.myBlack, 15, FontWeight.w400),),
                              const Spacer(),
                              PopupMenuButton(
                                  itemBuilder: (context) => [

                                    PopupMenuItem(
                                      value: 1,
                                      child:  Text("Dislike",style: textStyle(
                                          AppColors.primaryColor,
                                          15,
                                          FontWeight.w400
                                      )
                                      ),
                                      onTap: (){
                                        cubit.updateFavorite(F: 'no', id: cubit.favorite[index]['id']);
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
                        itemCount: cubit.favorite.length
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
