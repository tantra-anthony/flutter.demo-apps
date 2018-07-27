import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  // create state for LoginScreen
  @override
    LoginScreenState createState() {
      return LoginScreenState();
    }
}

class LoginScreenState extends State<LoginScreen> {

  // add text field controllers to clear the text field's values
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea( //safe area protects view from the rounded notches in newer phones
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0), //adds padding to ListView
            children: <Widget>[
              SizedBox(height: 120.0), // SizedBox is to add an empty space in between objects
              Column(
                children: <Widget>[
                  Image.asset('assets/misty_logo.png'),
                  SizedBox(height: 16.0),
                  Text('MISTY')
                ],
              ),
              SizedBox(height: 80.0),
              TextField( //username field
                decoration: InputDecoration(
                  filled: true, // use this to make the box transparent or not
                  labelText: "Username"
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 12.0),
              TextField( //password field
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Password"
                ),
                controller: _passwordController,
                obscureText: true, // user this to obscure the text for passwords
              ),
              SizedBox(height: 24.0),
              OutlineButton(
                highlightColor: Colors.white,
                shape: StadiumBorder(), // stadium border is for rounded edges
                onPressed: () {
                  _passwordController.clear();
                  _usernameController.clear();
                },
                child: Text(
                  'CLEAR',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
}
