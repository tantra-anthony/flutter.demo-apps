import 'package:flutter/material.dart';

import 'home.dart';
import 'landing.dart';

class GridViewApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: 'Grid View',
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/home': (context) => HomePage()
        },      
      );
    }
  
  // Route<dynamic> _getRoute(RouteSettings settings) {
  //   if (settings.name != '/login') {
  //     return null;
  //   }

  //   return MaterialPageRoute<void>(
  //     settings: settings,
  //     builder: (BuildContext context) => LoginPage(),
  //     fullscreenDialog: true,
  //   );
  // }
}