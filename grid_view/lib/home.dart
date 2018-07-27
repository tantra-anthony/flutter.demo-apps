import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          // add buttons and appbar
          title: Text("Grid View"),
          leading: IconButton( // leading: left, trailing: right according to RTL (English)
            icon: Icon(Icons.menu),
            onPressed: () {
              debugPrint('Menu Button Pressed');
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("Search Button Pressed");
              },
            )
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2, // how many items across
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0, //aspect of children
          children: _buildGrid(10),
        ),
      );
    }

  List<Card> _buildGrid (int count) {
    List<Card> cards = List.generate(
      count, 
      (int index) => Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 8.0),
                  AspectRatio(
                    aspectRatio: 18.0 / 11.0,
                    child: Image.asset('assets/misty_logo.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Misty'),
                        SizedBox(height: 8.0),
                        Text('is kewl')
                      ],
                    ),
                  )
                ],
              ),
            )
    );

    return cards;
  }
}