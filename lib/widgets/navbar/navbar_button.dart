import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineupmaster/data/models/team.dart';
import 'package:lineupmaster/providers/selected_team.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

class NavBarButton extends StatelessWidget {

  final String _fileName ;
  final String _label;
  final Function() _onPressed;
  final bool _isSelected;

  const NavBarButton({
    super.key, 
    required fileName, 
    required label, 
    required onPressed, 
    required isSelected,
  }) 
    : _fileName = fileName , _label = label , _onPressed = onPressed, _isSelected = isSelected;

 
  @override
  Widget build(BuildContext context) {

    final selectedTeamModel = Provider.of<SelectedTeamModel>(context);    
    Team? selectedTeam = selectedTeamModel.selectedTeam;

    // method to  return appropriate color based on selectedTeam's theme color
    Color getButtonColor() {
      if (selectedTeam == null) {
          return primaryColor;
      }
      else {
        String themeColor = selectedTeam.themeColor;
        if (themeColor == 'green') {
          return primaryColor;
        }
        else if (themeColor == 'blue') {
          return blueColor;
        }
        else if (themeColor == 'red') {
          return redColor;
        }
        return purpleColor;
      }
    }
    
   return InkWell(
    onTap: _onPressed,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8), // Adjust the radius if needed
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/icons/$_fileName',
            height: 33,
            width: 33,
            color: !_isSelected ? blackColor : getButtonColor(),
          ),
          Text(
            _label,
            style: TextStyle(
              color: !_isSelected ? blackColor : getButtonColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
    
  }
}