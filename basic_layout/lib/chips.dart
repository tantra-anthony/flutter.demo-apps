import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chip(
              label: Text('Hello'),
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text('Hi'),
              ),
              deleteIconColor: Colors.blue,
              deleteIcon: Icon(Icons.ac_unit),
              shape: StadiumBorder(),
            ),
            Chip(
              label: Text('Hello'),
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.ac_unit),
              ),
              deleteIconColor: Colors.blue,
              deleteIcon: Icon(Icons.ac_unit),
              shape: StadiumBorder(),
            ),
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Text('H'),
            ),
            InputChip(
              label: Text('Hello'),
              avatar: CircleAvatar(
                backgroundColor: Colors.cyan,
                child: Text('AT'),
              ),
              onPressed: () {},
              deleteIcon: Icon(Icons.cancel),
            ),
            ActionChip(
              onPressed: () {},
              label: Text('Hello'),
              backgroundColor: Colors.pink,
              tooltip: 'I\'m a chip',
            )
          ],
        ),
      );
    }
}