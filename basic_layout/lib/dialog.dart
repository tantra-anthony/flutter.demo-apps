import 'package:flutter/material.dart';
import 'dart:async';


// use enum to show the buttons
enum Answer{YES, NO, MAYBE}


class DialogWidget extends StatefulWidget {

  @override
    _DialogWidgetState createState() {
      // TODO: implement createState
      return _DialogWidgetState();
    }
}

class _DialogWidgetState extends State<DialogWidget> {

  String _answer = '';

  void setAnswer(String value) {
    setState(() {
          _answer = value;
        });
  }

  @override
  Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('You answered $_answer'),
            RaisedButton(
              child: Text("Simple Dialog"),
              onPressed: () {_showSimpleDialog();},
            ),
            SizedBox(height: 40.0),
            RaisedButton(
              child: Text("Alert Dialog"),
              onPressed: () {_showAlertDialog();},
            ),
          ],
        ),
      );
    }
  
  Future<Null> _showSimpleDialog() async {
    switch(
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
          title: Text('Hey'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, Answer.YES),
                child: Text('YES'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, Answer.NO),
                child: Text('NO'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, Answer.MAYBE),
                child: Text('MAYBE'),
              )
            ],
          );
        }
      )
    ) {
      case Answer.YES:
        setAnswer('Yes');
        break;
      case Answer.NO:
        setAnswer('No');
        break;
      case Answer.MAYBE:
        setAnswer('Maybe');
        break;
    }
  }

  Future<Null> _showAlertDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hello"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("hello 2"),
                Text("hello 3")
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Action"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }
  
}