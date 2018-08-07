import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget { // top must be a statelesswidget
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold (
        body: DraggableBoxes(),
      );
    }
}

class DraggableBoxes extends StatefulWidget {
  @override
    _DraggableWidgetState createState() {
      // TODO: implement createState
      return _DraggableWidgetState();
    }
}

class _DraggableWidgetState extends State<DraggableBoxes> {
  Color caughtColor;

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        body: Stack( // stack lines up the objects in two of the four sides
          children: <Widget>[
            DragBox(Offset(0.0, 0.0), 'Hello 1', Colors.lime),
            DragBox(Offset(100.0, 0.0), 'Mundo 2', Colors.orange),
            Positioned(
              left: 100.0,
              bottom: 0.0,
              child: DragTarget(
                onAccept: (Color color) { // takes in a color, inside the function needs to match with 'data' constructor of draggable
                  caughtColor = color; //data
                }, // this will fire when it accepts a widget
                builder: ( // requires a builder
                  BuildContext context, 
                  List<dynamic> accepted,  // widgets that get accepted when dragged into the dragtarget
                  List<dynamic> rejected // items that get rejected when dragged into dragtarget
                ) {
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: accepted.isEmpty ? caughtColor : Colors.grey.shade200, // if nothing is accepted we color with grey or else we colow with caught color
                    ),
                    child: Center(
                      child: Text('Drag Here'),
                    ),
                  );

                },
              ),
            )
          ],
        )
      );
    }
}

//build a draggable box here
class DragBox extends StatefulWidget {
  final Offset initPos;
  final String label;
  final Color itemColor;
  
  // constructors
  DragBox(this.initPos, this.label, this.itemColor); 

  @override
    _DragBoxState createState() {
      // TODO: implement createState
      return _DragBoxState();
    }
}

class _DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0); // set default value

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      position = widget.initPos; // inherited from DragBox, item will sit at the initPos
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Positioned( // allows us to position the child element on the stack, this is a norm for Stack widget
        left: position.dx,
        top: position.dy, //based on the offset we put the initial pos of the item
        child: Draggable(
          feedback: Container(
            width: 120.0, // change size when dragged
            height: 120.0,
            color: widget.itemColor.withOpacity(0.5), // change opacity when dragged,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
                ),
              ),
            ),
          ),// what it looks like when it's dragged,
          onDraggableCanceled: (velocity, offset) {
            setState(() {
                          position = offset; // reset the position (remember left and top in this positioned widget)
                        });
          }, //so we can move our box around,
          data: widget.itemColor, // actual item/data we're dropping from the draggable,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.itemColor,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
          )
        ),
      );
    }
}