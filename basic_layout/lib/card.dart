import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.max, 
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('I\'m the title'),
                    subtitle: Text("I'm the subtitle"),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {},
                          child: Text('Hello'),
                        )
                      ],
                    ),
                  )
                ],
              ),
              elevation: 1.0, // standard is 1.0 dp
              margin: EdgeInsets.all(8.0), // takes in an edgeinset widget
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),

            )
          ],
        )
      );
    }
}