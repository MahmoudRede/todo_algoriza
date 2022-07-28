import 'package:flutter/material.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';
import 'package:to_do_algoriza/presentation/widgets/text_manager.dart';

class ButtonManager extends StatelessWidget {
  const ButtonManager({Key? key, required this.title, required this.function}) : super(key: key);

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 0
      ),
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        color: AppColors.primaryColor,
        onPressed: (){
          function();
        },
        child: Text(title,style: textStyle(AppColors.myWhite, 15, FontWeight.w500),),
      ),
    );
  }
}
