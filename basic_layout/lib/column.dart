import 'package:flutter/material.dart';

class ColumnWidget extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column( // column is a vertically arranged linear layout
          // mainAxisAlignment: , // main axis (spans vertically)
          crossAxisAlignment: CrossAxisAlignment.start, // this is the non-major axis (means spanning horizontally)
          mainAxisSize: MainAxisSize.min, // this is the size that spans vertically (shrink to fit = min)
          children: <Widget>[
            Text('First item in column'),
            Text('Second item in column'),
            Text('Third item in column') // column and row are built in the same algorithm
            // Expanded( // expanded here makes sure that every child has enough space
            //   child: FittedBox(
            //     fit: BoxFit.contain,
            //     child: FlutterLogo(),
            //   ),
            // )
          ],
      )
      );
    }

}