import 'package:flutter/material.dart';

class PitchOption extends StatelessWidget {

  final String imageName;
  final String label;
  final bool isSelected;
  final String colorName;
  final Function onPitchChange;

  const PitchOption({
    super.key, 
    required this.imageName,
    required this.label,
    required this.isSelected,
    required this.onPitchChange,
    required this.colorName
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { onPitchChange(colorName); },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 100,
            decoration: BoxDecoration(
              border: isSelected ? Border.all(color: Colors.blue, width: 3) : Border.all(width: 0),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('lib/assets/pitches/$imageName'),
                fit: BoxFit.cover
              )                        
            ),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}