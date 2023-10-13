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

    Color getButtonColor() {
      
      if (selectedTeam == null) {
          return blackColor;
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
    
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent), // removing default bg color
        shadowColor: MaterialStatePropertyAll(Colors.transparent) , // removing shadow of the button
        overlayColor: MaterialStatePropertyAll(Colors.transparent) // removing effect when we click
      ),
      onPressed: _onPressed, 
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
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ) 
    ) ;
  }
}