import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/physical_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'calculator_brain.dart';
import 'results_page.dart';

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PhysicalData physicalData =
        Provider.of<PhysicalData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: ReusableCard(
                      cardChild: IconContent(
                        label: 'MALE',
                        icon: FontAwesomeIcons.mars,
                      ),
                      color: physicalData.getGender == Gender.male
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      onPress: () {
                        physicalData.toggleMale();
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: ReusableCard(
                      color: physicalData.getGender == Gender.female
                          ? kActiveCardColor
                          : kInactiveCardColor,
                      onPress: () {
                        physicalData.toggleFemale();
                      },
                      cardChild: IconContent(
                        label: 'FEMALE',
                        icon: FontAwesomeIcons.venus,
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Consumer<PhysicalData>(
                          builder: (_, data, __) {
                            return Text(
                              data.getHeight.toString(),
                              style: kNumberTextStyle,
                            );
                          },
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Color(0xFF8D8E98),
                          thumbColor: Color(0xFFED1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Consumer<PhysicalData>(
                        builder: (_, data, __) {
                          return Slider(
                            value: physicalData.getHeight.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            onChanged: (double newValue) {
                              physicalData.changeHeight(newValue.round());
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Consumer<PhysicalData>(
                            builder: (_, data, __) {
                              return Text(
                                data.getWeight.toString(),
                                style: kNumberTextStyle,
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  physicalData.decrementWeight();
                                },
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  physicalData.incrementWeight();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: ReusableCard(
                      color: kActiveCardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: kLabelTextStyle,
                          ),
                          Consumer<PhysicalData>(
                            builder: (_, data, __) {
                              return Text(
                                data.getAge.toString(),
                                style: kNumberTextStyle,
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  physicalData.decrementAge();
                                },
                              ),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  physicalData.incrementAge();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(
                  height: physicalData.getHeight,
                  weight: physicalData.getWeight);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultsPage(
                            bmiResult: calc.calculateBMI(),
                            resultText: calc.getResult(),
                            interpretation: calc.getInterpretation(),
                          )));
            },
            buttonTitle: 'CALCULATE',
          ),
        ],
      ),
    );
  }
}
