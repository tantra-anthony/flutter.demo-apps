import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Placeholder(
              fallbackHeight: 100.0,
              fallbackWidth: 40.0,
              strokeWidth: 5.0,
              color: Colors.black,
            )
          ] 
        ),
      );
    }
}