import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_algoriza/presentation/styles/colors.dart';


class DefaultFormField extends StatelessWidget {

  final String hint;
  final bool isPassword;
  TextInputType ?textInputType;
  final TextEditingController controller;
  IconData ?suffixIcon;
  Function ?suffixFunction;
  Function ?function;
  Widget? prefixWidget;
  final String validText;

  DefaultFormField({
    required this.hint,
    required this.controller,
    this.textInputType,
    this.isPassword=false,
    this.suffixIcon,
    this.suffixFunction,
    this.function,
    this.prefixWidget,
    required this.validText,
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: (){
        function!();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: hint,
        hintStyle: GoogleFonts.roboto(
          fontSize: 15.0,
          color: Colors.grey[400],
          fontWeight: FontWeight.w500
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12)
        ),
        prefixIcon: prefixWidget,
        suffixIcon: IconButton(onPressed: (){suffixFunction!();}, icon: Icon(suffixIcon),color: Colors.grey.shade400,),
      ),
      style: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 15,
      ),
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      validator: (value){
        if(value!.isEmpty){
          return validText;
        }
        else
        {
          return null;
        }
      },
    );
  }
}