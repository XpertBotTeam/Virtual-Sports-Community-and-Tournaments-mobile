import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lineupmaster/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  
  final TextEditingController textEditingController;
  final bool shiny;
  final Color? color;
  final Function? onChange;
  final bool numeric ;

  const CustomTextField(
    this.textEditingController, 
    {
      super.key, 
      this.shiny = true, 
      this.color,
      this.onChange, 
      this.numeric = false
    }
  );

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
        color: color ?? lightGray,
      ),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
        // limiting user input to numeric if requested
        inputFormatters: numeric? 
          <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
          ] :
          null ,
        decoration: const InputDecoration(
          isDense: true, // remove default size
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          border: InputBorder.none,
        ),
      )
    );
  }
}