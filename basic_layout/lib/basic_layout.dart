import 'package:flutter/material.dart';

//importing all the basic layout files
import 'container.dart';
import 'row.dart';
import 'column.dart';
import 'image.dart';
import 'text.dart';
import 'icons.dart';
import 'buttons.dart';
import 'placeholder.dart';
import 'switch.dart';
import 'selection_controls.dart';
import 'slider.dart';

class BasicLayoutApp extends StatelessWidget {

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        title: 'Basic Layout App',
        // home: ContainerWidget() // insert with appropriate demo file,
        // home: RowWidget(),
        // home: ColumnWidget(),
        // home: ImageWidget(),
        // home: TextWidget(),
        // home: IconWidget(),
        // home: ButtonWidget(),
        // home: PlaceholderWidget(),
        // home: SwitchWidget(),
        // home: SelectionControlsWidget(),
        home: SliderWidget(),
      );
    }

}