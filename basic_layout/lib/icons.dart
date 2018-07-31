import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: () {},
            ),
            Icon(Icons.accessibility)
          ],
        ),
      );
    }
}