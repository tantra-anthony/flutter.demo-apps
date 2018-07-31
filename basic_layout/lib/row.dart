import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold (
        body: Row( // row returns a horizontally arranged linear layout
        children: <Widget>[ // row expands to container
          Expanded( //makes sure that all items are of same width
            child: Text(
              'This is the first item in the row',
              textAlign: TextAlign.center,
            )
          ),
          Expanded( // expanded makes sure that this child and other children have space
            child: Text(
              'This is the second item in the row',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: FlutterLogo()
            )
          )
      ],
      ),
      );
      
    }
}