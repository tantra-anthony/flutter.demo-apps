import 'package:flutter/material.dart';

// this example is taken from flutter demo

const String _introText =
  'Tooltips are short identifying messages that briefly appear in response to '
  'a long press. Tooltip messages are also used by services that make Flutter '
  'apps accessible, like screen readers.';

class TooltipWidget extends StatelessWidget {

  static const String routeName = '/material/tooltips';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return  Scaffold(
      appBar:  AppBar(
        title: const Text('Tooltips')
      ),
      body:  Builder(
        builder: (BuildContext context) {
          return  SafeArea(
            top: false,
            bottom: false,
            child:  ListView(
              children: <Widget>[
                 Text(_introText, style: theme.textTheme.subhead),
                 Row(
                  children: <Widget>[
                     Text('Long press the ', style: theme.textTheme.subhead),
                     Tooltip(
                      message: 'call icon',
                      child:  Icon(
                        Icons.call,
                        size: 18.0,
                        color: theme.iconTheme.color
                      )
                    ), // the 'parent' is put inside the child, the standard action is a 'long press'
                     Text(' icon.', style: theme.textTheme.subhead)
                  ]
                ),
                 Center(
                  child:  IconButton(
                    iconSize: 48.0,
                    icon: const Icon(Icons.call),
                    color: theme.iconTheme.color,
                    tooltip: 'Place a phone call', // tooltips can be a standard constructor of the widget as well, 'long press' is also the action
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(const SnackBar(
                         content: Text('That was an ordinary tap.')
                      ));
                    }
                  )
                )
              ]
              .map((Widget widget) {
                return  Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: widget
                );
              })
              .toList()
            ),
          );
        }
      )
    );
  }
}