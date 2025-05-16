import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import '../components/bottom_button.dart';

class ResultPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;
  final String interpretation;

  ResultPage({required this.bmiResult, required this.resultText, required this.interpretation});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calctor', style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomLeft,
          child: Text('Your Result', style: k0TitleTextStyle,),
        )),
        Expanded(
          flex: 5,
            child: ReusableCard(
              colour: k0ActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(resultText.toUpperCase(), style: k0ResultTextStyle,),
                  Text(bmiResult, style: k0BMITextStyle),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text(interpretation, style: k0BodyTextStyle),
                  ),
                ],
              ),
            )),
        BottomButton(buttonTitle: 'RE Calc it ~',
        onPressed: () {
          Navigator.pop(context);
        },)
      ],),
    );
  }
}
