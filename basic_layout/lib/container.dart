import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
      child: Container(
        padding: EdgeInsets.all(8.0), // adds padding
        margin: EdgeInsets.all(10.0), // adds margin
        // height: 400.0, // specifies the height
        // width: 40.0, // specifies the width, no width/height means it's wrap content
        color: Colors.teal.shade700,
        child: Text('Hello World'),
        foregroundDecoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.ytimg.com/vi/wRx3Uvcktm8/maxresdefault.jpg'),
            // centerSlice: Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0) //
          ),
        )
      )
    )
    );
  }
}