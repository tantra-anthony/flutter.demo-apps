import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  @override
    _SliderWidgetState createState() {
      // TODO: implement createState
      return _SliderWidgetState();
    }
}

class _SliderWidgetState extends State<SliderWidget> {

  double sliderValue = 0.0;

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Slider(
              value: sliderValue,
              divisions: 10,
              min: 0.0,
              max: 100.0,
              label: 'Hello',
              onChanged: (double newValue) {
                setState(() {
                                sliderValue = newValue;
                                print(sliderValue);  
                                });
              },
            )
          ] 
        ),
      );
    }
}
