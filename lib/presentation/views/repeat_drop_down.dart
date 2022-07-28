import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_cubit.dart';
import 'package:to_do_algoriza/business_logic/app_cubit/app_states.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/styles/icon_broken.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class RepeatDropDown extends StatelessWidget {
  const RepeatDropDown({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){

      },
      builder: (context,state){
        return  Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(width: 1,color: AppColors.myGreyLight),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                10,
                5,
                10,
                5
            ),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(12),
              underline: Container(
                color: AppColors.myGreyLight,
              ),
              dropdownColor: AppColors.myGreyLight,
              elevation: 0,
              hint: TodoCubit.get(context).repeatValue.isEmpty
                  ? Text('Weakly', style:  TextStyle(color: Colors.grey.shade400, fontSize: 14.0 , fontWeight: FontWeight.bold),)
                  : Text(
                  TodoCubit.get(context).repeatValue,
                  style: textStyle(Colors.grey.shade400, 15, FontWeight.w500)
              ),
              isExpanded: true,
              icon: Icon(IconBroken.Arrow___Down_2,color: Colors.grey.shade400,),
              style: textStyle(AppColors.myBlack,  15.0 , FontWeight.w400),
              items: ['None','Daily','Weekly','Monthly'].map(
                    (value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              onChanged: (value){
                TodoCubit.get(context).repeatDropDown(value);
              },
            ),
          ),

        );
      },
    );
  }
}
