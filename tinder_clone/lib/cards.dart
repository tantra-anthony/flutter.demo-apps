
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/layout.dart';
import 'package:tinder_clone/photos.dart';

class DraggableCard extends StatefulWidget {
  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with TickerProviderStateMixin {

  Offset cardOffset = Offset(0.0, 0.0);
  Offset dragStart;
  Offset dragPosition;
  Offset slideBackStart;
  AnimationController slideBackAnimation;

  @override
  void initState() {
    super.initState();
    slideBackAnimation = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this
    )
    ..addListener(() => setState(() {
      cardOffset = Offset.lerp(
        slideBackStart, 
        Offset(0.0, 0.0), 
        Curves.elasticOut.transform(slideBackAnimation.value)
      );
    }))
    ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
                      dragStart = null;
                      slideBackStart = null;
                      dragPosition = null;
                    });
        }
    });
    
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    super.dispose();
  }

  void _onPanEnd(DragEndDetails details) {
    slideBackStart = cardOffset;
    slideBackAnimation.forward(from: 0.0);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
          dragPosition = details.globalPosition;
          cardOffset = dragPosition - dragStart;
        });
  }

  void _onPanStart(DragStartDetails details) {
    dragStart = details.globalPosition;

    // handle when user drags during animation
    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop(canceled: true);
    }
  }

  double _rotation(Rect dragBounds) {
    // to prevent from rotating too much
    if (dragStart != null) {
      final rotationCornerMultiplier = dragStart.dy >= dragBounds.top + (dragBounds.height / 2) ? -1 : 1;
      return (pi / 8) * (cardOffset.dx / dragBounds.width) * rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if (dragStart != null) {
      return dragStart - dragBounds.topLeft;
    } else {
      return Offset(0.0, 0.0); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnchoredOverlay( // from fluttery package
      showOverlay: true,
      child: Center(),
      overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
        // build cards here
        return CenterAbout( // any child will be centred about this position
          position: anchor,
          child: Transform(
            transform: Matrix4.translationValues(cardOffset.dx, cardOffset.dy, 0.0)
              ..rotateZ(_rotation(anchorBounds)),
            origin: _rotationOrigin(anchorBounds),
            child: Container(
              width: anchorBounds.width,
              height: anchorBounds.height, // the overlay covers whole page
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                child: ProfileCard(),
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
              ),
            ),
          )
        );
      },
    );
  }

}

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  Widget _buildBackground() {
    return PhotoBrowser(
      photoAssetPaths: [
        'assets/photo_1.jpg',
        'assets/photo_2.jpg',
        'assets/photo_3.jpg',
        'assets/photo_4.jpg',
      ],
      visiblePhotoIndex: 0
    );
  }

  Widget _buildCardProfile() {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8)
            ]
          ), //this is how you add gradien
        ),
        padding: EdgeInsets.all(24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded( // to push the icon to the right
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'First Last',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0
                    ),
                  ),
                  Text(
                    'Some Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.info,
              color: Colors.white,
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 5.0,
            spreadRadius: 2.0
          )
        ]
      ),
      child: ClipRRect( //clip the corners of the photo
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBackground(),
              _buildCardProfile()
            ],
          ),
        ),
      ),      
    );
  }
}
