import 'package:flutter/material.dart';
import '../constants.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonTitle;

  const BottomButton({this.buttonTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: k0BottomPanelColour,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: k0BottomContainerHeight,
        child: Center(
          child: Text(
            buttonTitle!,
            style: k0LargeButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
