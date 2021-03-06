import 'package:flutter/material.dart';
import 'package:tinder_clone/cards.dart';
import 'package:tinder_clone/profiles.dart';

import 'package:tinder_clone/matches.dart';

void main() => runApp(new MyApp());

final MatchEngine matchEngine = new MatchEngine(
  matches: demoProfiles.map((Profile profile) {
    return DateMatch(profile: profile);
  }).toList(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primaryColorBrightness: Brightness.light, //for iOS users to see the status bar
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Tinder for Cats'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //build app bar
  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.person,
          color: Colors.grey,
          size: 40.0,
        ),
        onPressed: () {
          // TODO:
        },
      ),
      title: FlutterLogo(
        size: 30.0,
        colors: Colors.purple,
        
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.chat_bubble,
            color: Colors.grey,
            size: 40.0
          ),
          onPressed: () {
            // TODO
          },
        )
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //distributes members equally
          children: <Widget>[
            RoundIconButton.small(
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: () {
                // TODO
              },
            ),
            RoundIconButton.large(
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {
                matchEngine.currentMatch.nope();
              },
            ),
            RoundIconButton.small(
              icon: Icons.star,
              iconColor: Colors.blue,
              onPressed: () {
                matchEngine.currentMatch.superLike();
              },
            ),
            RoundIconButton.large(
              icon: Icons.favorite,
              iconColor: Colors.green,
              onPressed: () {
                matchEngine.currentMatch.like();
              },
            ),
            RoundIconButton.small(
              icon: Icons.lock,
              iconColor: Colors.purple,
              onPressed: () {
                // TODO
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(), 
      body: CardStack(
        matchEngine: matchEngine,
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}


//round icon for bottom bar
class RoundIconButton extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 60.0; //named constructors, to do different stuff, set size to 60.0
  
  RoundIconButton.small({
    this.icon,
    this.iconColor,
    this.onPressed
  }) : size = 50.0;
  
  RoundIconButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed
  });

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container( // container needed for shadow
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 10.0,
            ),
          ], // can apply multiple shadows
        ), // turn into circle
        child: RawMaterialButton(
          shape: CircleBorder(),
          elevation: 0.0,
          child: Icon(
            icon,
            color: iconColor,

          ),
          onPressed: onPressed,
        ),
      );
    }

}
