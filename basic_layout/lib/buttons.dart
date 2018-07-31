import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
            ),
            RaisedButton(
              onPressed: () {},
              shape: StadiumBorder(),
            ),
            OutlineButton(
              onPressed: () {},
              shape: StadiumBorder(),
              // borderSide: , // modifies the border color (use ThemeData for this)

            ),
            // DropdownButton(
            //   items: ,
            // ),
            FloatingActionButton(
              onPressed: () {},
            ),
            RawMaterialButton(
              onPressed: () {},
            )
          ],
        ),
      );
    }
}