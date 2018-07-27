import 'package:flutter/material.dart';
import 'landing.dart';
import 'grid_view.dart';

class LandingPage extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        title: 'Grid View',
        home: GridViewApp(),
        initialRoute: '/landing',
        routes: {
          '/landing'
        },
      );
    }

  
}