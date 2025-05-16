import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/sexual_info_card.dart';
import '../components/reusable_card.dart';
import '../constants.dart';
import 'result_page.dart';
import '../components/bottom_button.dart';
import 'package:bmi_calculator/calc_brain.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // 当前选中的性别
  Gender? selectedGender;
  int height = 170;
  int weight = 66;
  int age = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI CALCULATOR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    colour: selectedGender == Gender.male
                        ? k0ActiveCardColor
                        : k0InactiveCardColor,
                    cardChild: SexualInfoCard(
                      gender: Gender.male,
                      isSelected: selectedGender == Gender.male,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    colour: selectedGender == Gender.female
                        ? k0ActiveCardColor
                        : k0InactiveCardColor,
                    cardChild: SexualInfoCard(
                      gender: Gender.female,
                      isSelected: selectedGender == Gender.female,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: k0ActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: k0LabelTextStyle,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: k0NumberTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ' cm',
                          style: k0LabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: k0ActiveIconColor,
                      thumbColor: k0BottomPanelColour,
                      overlayColor: Color(0xa9eb1555),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 15,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 23,
                      ),
                    ),
                    child: Slider(
                        value: height.toDouble(),
                        min: 99,
                        max: 501,

                        inactiveColor: k0InactiveIconColor,
                        onChanged: (double nv) {
                          setState(() {
                            height = nv.round();
                          });
                        }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WEIGHT', style: 
                          k0LabelTextStyle,),
                        Text(weight.toString(),
                        style: k0NumberTextStyle,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundIconButton(
                              child: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (weight > 1) {
                                    weight--;
                                  }
                                });
                              },
                            ),
                            RoundIconButton(
                              child: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  if (weight < 300) {
                                    weight++;
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('AGE', style:
                        k0LabelTextStyle,),
                        Text(age.toString(),
                          style: k0NumberTextStyle,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundIconButton(
                              child: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (age > 1) {
                                    age--;
                                  }
                                });
                              },
                            ),
                            RoundIconButton(
                              child: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  if (age < 120) {
                                    age++;
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'Submit',
            onPressed: () {
              CalcBrain cb = CalcBrain(height: height, weight: weight);


              Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(bmiResult: cb.calcBMI(), resultText: cb.getResult(),
                interpretation: cb.getInterpretation(),
              )));
            },
          ),
        ],
      ),
    );
  }
}


class RoundIconButton extends StatelessWidget {

  RoundIconButton({this.child, this.onPressed});

  final IconData? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      child: Icon(child),
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xff4c4f5e),
    );
  }
}


