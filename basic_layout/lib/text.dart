import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      String _name = 'Anthony';

      return Scaffold(
        body: Column(
          children: <Widget>[
            Text(
              'Hello $_name! How are you?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                text: 'Hello ',
                // style: , // must insert text style
                children: <TextSpan>[
                  TextSpan(text: 'bold', style: new TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' world!'),
                ],
              ),
            )
          ],
        ),
      );
    }
}