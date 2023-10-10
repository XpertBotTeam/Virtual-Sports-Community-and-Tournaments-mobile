import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  
  final String title;

  const SectionTitle(this.title , {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    ) ;
  }
}