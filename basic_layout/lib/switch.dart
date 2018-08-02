import 'package:flutter/material.dart';

// includes some snackbar implementation
final snackBar = SnackBar(
  content: Text('I am a text'),
  backgroundColor: Colors.pink,
  action: SnackBarAction(
    label: 'Hello',
    onPressed: () {},
  ),
);

class SwitchWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Switchy(),
            RaisedButton(
              onPressed: () {},
            )
          ] 
        ),
      );
    }
}

class Switchy extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Switch(
        value: false,
        onChanged: (bool value) {
          print(value);
          Scaffold.of(context).showSnackBar(snackBar); //Scaffold.of cannot be immediately below Scaffold object must be separated
        },

      );
    }
}