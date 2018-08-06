import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatefulWidget {
  @override
    _ChoiceChipWidgetState createState() {
      // TODO: implement createState
      return _ChoiceChipWidgetState();
    }
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {

  // implement counter for choice chips
  int _value = 1;
  // choice chips is similar to radio buttons

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List<Widget>.generate(3, (int index) { // remember that children of column takes in a list of widgets
            return ChoiceChip(
              label: Text('Hello $index'),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() { // remember to setState
                                  
                _value = selected ? index : null;
                                });
              },
            );
          })
        ),
        )
      );
    }
}
