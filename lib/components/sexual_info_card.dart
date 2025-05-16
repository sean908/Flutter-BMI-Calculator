import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class SexualInfoCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;

  SexualInfoCard({
    required this.gender,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          gender == Gender.male ? FontAwesomeIcons.mars : FontAwesomeIcons.venus,
          size: 80.0,
          color: isSelected ? k0ActiveIconColor : k0InactiveIconColor,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          gender == Gender.male ? 'MALE' : 'FEMALE',
          style: TextStyle(
            fontSize: 18.0,
            color: isSelected ? k0ActiveIconColor : k0InactiveIconColor,
          ),
        ),
      ],
    );
  }
}
