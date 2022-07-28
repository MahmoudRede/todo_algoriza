import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate=DateTime.now();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=TodoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Schedule',
                style: textStyle(
                    AppColors.myBlack,
                    20,
                    FontWeight.w600),),
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 20
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    height: 80,
                    width: 60,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primaryColor,
                    selectedTextColor: AppColors.myWhite,
                    dateTextStyle: textStyle(AppColors.myBlack, 18, FontWeight.w500),
                    dayTextStyle: textStyle(AppColors.myBlack, 13, FontWeight.w500),
                    monthTextStyle: textStyle(AppColors.myBlack, 13, FontWeight.w500),
                    onDateChange: (date){

                      setState((){
                        cubit.time='${date.month}/${date.day}/${date.year}';
                        debugPrint(cubit.time);
                        cubit.getDatabase(cubit.database);
                        selectedDate=date;
                        debugPrint(DateFormat.EEEE().format(selectedDate));

                      });


                    },

                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.myGrey,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 20
                  ),
                  child: Row(
                    children: [
                      Text(DateFormat.EEEE().format(selectedDate),style: textStyle(AppColors.myBlack, 18, FontWeight.w500),),
                      const Spacer(),
                      Text(DateFormat.yMMMd().format(selectedDate),style: textStyle(Colors.black87, 16, FontWeight.w400,)),

                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 22,
                    ),
                    child: ListView.separated(
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              if(cubit.schedule[index]['state']=='completed'){
                                cubit.updateDatabase(S: 'unComplete', id: cubit.schedule[index]['id']);
                              }
                              else{
                                cubit.updateDatabase(S: 'completed', id: cubit.schedule[index]['id']);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(cubit.schedule[index]['color']),
                                  borderRadius: BorderRadius.circular(17)

                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(cubit.schedule[index]['start'],style: textStyle(AppColors.myWhite, 16, FontWeight.w500),),
                                      const SizedBox(height: 5,),
                                      Text(cubit.schedule[index]['title'],style: textStyle(AppColors.myWhite, 16, FontWeight.w500),),
                                    ],
                                  ),
                                  const Spacer(),
                                  cubit.schedule[index]['state']=='completed'?
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.myWhite,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: const Icon(Icons.done,color: AppColors.myWhite,size: 15,),
                                  ):Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.myWhite,
                                            width: 2
                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  )

                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context,index){
                          return const SizedBox(height: 10,);
                        },
                        itemCount: cubit.schedule.length
                    ),
                  ),
                )
              ],
            ),
          );
        },
    );
  }
}
