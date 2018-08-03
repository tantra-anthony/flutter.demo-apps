import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  @override
    _TextFieldWidgetState createState() {
      // TODO: implement createState
      return _TextFieldWidgetState();
    }
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  //for text fields, add a controller
  final _textFieldController1 = TextEditingController();

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textFieldController1, // add controller here
            ),
            SizedBox(
              height: 70.0,
            ),
            TextField( // this is a text field for a chat room for example
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                // labelText: 'I\'m a text field',
                hintText: 'I\'m a text field', // better for chat fields
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ) // usually we save this decoration object in our theme
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            RaisedButton(
              child: Text('Clear'),
              onPressed: () {
                print(_textFieldController1);
                print(_textFieldController1.text);
                print(_textFieldController1.selection);
                print(_textFieldController1.hashCode);
                _textFieldController1.clear();
              },
            )
          ] 
        ),
        )
      );
    }
}
