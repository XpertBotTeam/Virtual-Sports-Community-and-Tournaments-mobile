import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  
  final TextEditingController textEditingController;
  final bool shiny;

  const CustomTextField(this.textEditingController, {super.key, this.shiny = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 5,
            offset: shiny ?
              const Offset(0, 5) : 
              const Offset(0, 1) 
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: lightGray,
      ),
      child: TextField(
        controller: textEditingController,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          border: InputBorder.none,
        ),
      )
    );
  }
}