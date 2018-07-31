import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          children: <Widget>[
            Image.network('https://media.giphy.com/media/ASzK5wWjMtc6A/giphy.gif'), //can take gif and images
            // Image.asset('asset key') // to take from assets, must declare in pubspec.yaml
            // Image.file('file dir')
          ],
        ),
      );
    }
}