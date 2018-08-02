import 'package:flutter/material.dart';

class SelectionControlsWidget extends StatefulWidget {
  @override
    _SelectionControlsWidgetState createState() {
      // TODO: implement createState
      return _SelectionControlsWidgetState();
    }
}

class _SelectionControlsWidgetState extends State<SelectionControlsWidget> {

  bool _checkBoxValue = false;
  int radioValue = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
          radioValue = value;
        });

      print(radioValue);
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Checkbox(
              value: _checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                                  _checkBoxValue = newValue;
                                });
                print(_checkBoxValue);
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ //for radio buttons, it's preferred to have int (easier to manipulate)
                Radio<int>(
                  value: 0,
                  groupValue: radioValue,
                  onChanged: handleRadioValueChanged,
                ),
                Radio<int>(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: handleRadioValueChanged,
                ),
                Radio<int>(
                  value: 2,
                  groupValue: radioValue,
                  onChanged: handleRadioValueChanged,
                ),
              ],    
            )
          ] 
        ),
      );
    }
}
