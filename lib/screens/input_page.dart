import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // 导入Timer支持
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
  
  // 添加TextEditingController来控制输入字段
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  
  @override
  void initState() {
    super.initState();
    // 初始化控制器并设置初始值
    heightController = TextEditingController(text: height.toString());
    weightController = TextEditingController(text: weight.toString());
    ageController = TextEditingController(text: age.toString());
  }
  
  @override
  void dispose() {
    // 释放控制器
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }
  
  // 验证输入是否为数字且在有效范围内
  void validateAndUpdateHeight(String value) {
    if (value.isEmpty) return;
    
    try {
      int newHeight = int.parse(value);
      if (newHeight >= 99 && newHeight <= 501) {
        setState(() {
          height = newHeight;
        });
      } else {
        // 超出范围，恢复为原值
        heightController.text = height.toString();
      }
    } catch (e) {
      // 非数字输入，恢复为原值
      heightController.text = height.toString();
    }
  }

  // 验证weight输入
  void validateAndUpdateWeight(String value) {
    if (value.isEmpty) return;
    
    try {
      int newWeight = int.parse(value);
      if (newWeight >= 1 && newWeight <= 300) {
        setState(() {
          weight = newWeight;
          // 更新控制器显示新值
          weightController.text = weight.toString();
        });
      } else {
        // 超出范围，恢复为原值
        weightController.text = weight.toString();
      }
    } catch (e) {
      // 非数字输入，恢复为原值
      weightController.text = weight.toString();
    }
  }

  // 验证age输入
  void validateAndUpdateAge(String value) {
    if (value.isEmpty) return;
    
    try {
      int newAge = int.parse(value);
      if (newAge >= 1 && newAge <= 120) {
        setState(() {
          age = newAge;
          // 更新控制器显示新值
          ageController.text = age.toString();
        });
      } else {
        // 超出范围，恢复为原值
        ageController.text = age.toString();
      }
    } catch (e) {
      // 非数字输入，恢复为原值
      ageController.text = age.toString();
    }
  }

  // 创建一个自定义对话框方法，用于所有三个输入
  void showInputDialog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required String hintText,
    required String suffixText,
    required Function(String) onSave,
  }) {
    // 不在这里预先关闭键盘，让键盘行为更加一致
    
    showDialog(
      context: context,
      barrierDismissible: true, // 允许点击外部关闭对话框
      builder: (context) {
        // 使用StatefulBuilder允许在对话框内更新状态
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        // 确保触摸事件不会被吞噬
                        behavior: HitTestBehavior.opaque,
                        // 包装TextField，让它的点击行为更加一致
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // 设置为不自动聚焦，需要用户点击才会弹出键盘
                          autofocus: false,
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                          decoration: InputDecoration(
                            hintText: hintText,
                            suffixText: suffixText,
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixStyle: const TextStyle(color: Colors.black87),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: k0BottomPanelColour, width: 2.0),
                            ),
                          ),
                          // 确保输入焦点正常工作
                          onTap: () {
                            // TextField已经处理了焦点和键盘，这里不需要额外操作
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onSave(controller.text);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'SAVE',
                              style: TextStyle(
                                color: k0BottomPanelColour,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

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
                        InkWell(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Enter Height',
                              controller: heightController,
                              hintText: "99-501 cm",
                              suffixText: "cm",
                              onSave: validateAndUpdateHeight,
                            );
                          },
                          child: Text(
                            height.toString(),
                            style: k0NumberTextStyle,
                            textAlign: TextAlign.center,
                          ),
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
                            // 同步更新控制器
                            heightController.text = height.toString();
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
                        InkWell(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Enter Weight',
                              controller: weightController,
                              hintText: "1-300 kg",
                              suffixText: "kg",
                              onSave: validateAndUpdateWeight,
                            );
                          },
                          child: Text(
                            weight.toString(),
                            style: k0NumberTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundIconButton(
                              child: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (weight > 1) {
                                    weight--;
                                    weightController.text = weight.toString();
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
                                    weightController.text = weight.toString();
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
                        InkWell(
                          onTap: () {
                            showInputDialog(
                              context: context,
                              title: 'Enter Age',
                              controller: ageController,
                              hintText: "1-120 years",
                              suffixText: "years",
                              onSave: validateAndUpdateAge,
                            );
                          },
                          child: Text(
                            age.toString(),
                            style: k0NumberTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundIconButton(
                              child: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (age > 1) {
                                    age--;
                                    ageController.text = age.toString();
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
                                    ageController.text = age.toString();
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

class RoundIconButton extends StatefulWidget {
  final IconData? child;
  final VoidCallback? onPressed;

  const RoundIconButton({
    Key? key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  _RoundIconButtonState createState() => _RoundIconButtonState();
}

class _RoundIconButtonState extends State<RoundIconButton> {
  Timer? _timer;
  static const Duration _delay = Duration(milliseconds: 600); // 长按触发延迟
  static const Duration _interval = Duration(milliseconds: 100); // 连续点击间隔
  
  void _startTimer() {
    // 首先取消已存在的定时器
    _stopTimer();
    
    // 设置一个延迟，长按超过600ms后开始连续触发
    _timer = Timer(_delay, () {
      // 延迟后开始连续触发
      _timer = Timer.periodic(_interval, (timer) {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      });
    });
  }
  
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
  
  @override
  void dispose() {
    _stopTimer(); // 确保在组件销毁时取消定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _startTimer, // 长按开始
      onLongPressUp: _stopTimer, // 长按结束
      onLongPressCancel: _stopTimer, // 长按被取消
      child: RawMaterialButton(
        onPressed: widget.onPressed,
        elevation: 6.0,
        child: Icon(widget.child),
        constraints: const BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        shape: const CircleBorder(),
        fillColor: const Color(0xff4c4f5e),
      ),
    );
  }
}


