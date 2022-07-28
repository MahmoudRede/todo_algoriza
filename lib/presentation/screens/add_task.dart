import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/data/local/notification_helper.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/views/remind_drop_down.dart';
import 'package:to_do_algoriza/presentation/views/repeat_drop_down.dart';
import 'package:to_do_algoriza/presentation/widgets/button_manager.dart';
import 'package:to_do_algoriza/presentation/widgets/form_field.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

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
    return BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){

      },
      builder: (context,state){
          var cubit= TodoCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Add Task', style: textStyle(
                  AppColors.myBlack,
                  20,
                  FontWeight.w600),),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title',
                      style: textStyle(
                          AppColors.myBlack,
                          17,
                          FontWeight.w500
                      ),),
                    const SizedBox(height: 10,),
                    DefaultFormField(
                      function: (){},
                      hint: 'Design team meeting',
                      controller: cubit.titleController,
                      validText: 'Enter task title',
                      textInputType: TextInputType.text,

                    ),
                    const SizedBox(height: 10,),
                    Text('Deadline',
                      style: textStyle(
                          AppColors.myBlack,
                          17,
                          FontWeight.w500
                      ),),
                    const SizedBox(height: 10,),
                    DefaultFormField(
                            function: (){
                              showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2022-12-30')).then((value) {
                                 cubit.deadlineController.text= DateFormat.yMd().format(value!);
                              });
                            },
                            hint: '2022-07-25',
                            controller: cubit.deadlineController,
                            validText: 'Enter task date'),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                            child: Text('Start Time',
                              style: textStyle(
                                  AppColors.myBlack,
                                  17,
                                  FontWeight.w500
                              ),)),
                        const SizedBox(width: 15,),
                        Expanded(
                            child: Text('End Time',
                              style: textStyle(
                                  AppColors.myBlack,
                                  17,
                                  FontWeight.w500
                              ),)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                            child: DefaultFormField(
                              function: (){
                                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {

                                  cubit.startTimeController.text=value!.format(context).toString();

                                });
                              },
                              suffixIcon: Icons.timelapse,
                              validText: 'Enter start time',
                              hint: '11:00 Am',
                              controller: cubit.startTimeController,

                        )),
                        const SizedBox(width: 15,),
                        Expanded(
                            child: DefaultFormField(
                              function: (){
                                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {

                                  cubit.endTimeController.text=value!.format(context).toString();

                                });
                              },
                              suffixIcon: Icons.timelapse,
                              validText: 'Enter end time',
                              hint: '14:00 Pm',
                              controller: cubit.endTimeController,

                            )),
                      ],
                    ),
                    const SizedBox(height: 10,),


                    Text('Remind',
                      style: textStyle(
                          AppColors.myBlack,
                          17,
                          FontWeight.w500
                      ),),
                    const SizedBox(height: 10,),
                    const RemindDropDown(),
                    const SizedBox(height: 10,),
                    Text('Repeat',
                      style: textStyle(
                          AppColors.myBlack,
                          17,
                          FontWeight.w500
                      ),),
                    const SizedBox(height: 10,),
                    const RepeatDropDown(),
                    ButtonManager(title: 'Create a Task', function: (){
                      cubit.insertDatabase(
                          title: cubit.titleController.text,
                          deadline: cubit.deadlineController.text,
                          start: cubit.startTimeController.text,
                          end: cubit.endTimeController.text,
                          remind: cubit.remindValue,
                          repeat: cubit.repeatValue,
                      );

                      notifyHelper.scheduledNotification(
                        title:cubit.titleController.text,
                        content:TodoCubit.get(context).remindValue,
                        id:5
                      );

                      print(DateTime.now().hour.toString());
                      print(cubit.startTimeController.text);

                    })


                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}
