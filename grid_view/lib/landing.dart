import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView( // ListView makes every children's width stretch to the parent
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 2), // get screen size and adjust button position accordingly
            OutlineButton(
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // Navigate to home
              },
              child: Text(
                'NEXT',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )
      )
    );
  }
}
