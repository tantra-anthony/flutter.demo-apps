
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery/layout.dart';
import 'package:tinder_clone/photos.dart';

import 'package:tinder_clone/matches.dart';
import 'package:tinder_clone/profiles.dart';

class CardStack extends StatefulWidget {

  final MatchEngine matchEngine;

  CardStack({
    this.matchEngine,
  });

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {

  Key _frontCard;
  DateMatch _currentMatch;
  double _nextCardScale = 0.9;

  //operate on engine
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      widget.matchEngine.addListener(_onMatchEngineChanged);

      _currentMatch = widget.matchEngine.currentMatch;
      _currentMatch.addListener(_onMatchChanged);

      _frontCard = Key(_currentMatch.profile.name);
    }

  @override
    void didUpdateWidget(CardStack oldWidget) {
      // TODO: implement didUpdateWidget
      super.didUpdateWidget(oldWidget);

      if (widget.matchEngine != oldWidget.matchEngine) {
        oldWidget.matchEngine.removeListener(_onMatchEngineChanged);
        widget.matchEngine.addListener(_onMatchEngineChanged);

        if (_currentMatch != null) {
          _currentMatch.removeListener(_onMatchChanged);
        }

        _currentMatch = widget.matchEngine.currentMatch;
        if (_currentMatch != null) {
          _currentMatch.addListener(_onMatchChanged);
        }
      }
    }  

  @override
    void dispose() {
      if (_currentMatch != null) {
        _currentMatch.removeListener(_onMatchChanged);

      }
      widget.matchEngine.removeListener(_onMatchEngineChanged);
      // TODO: implement dispose
      super.dispose();

    }

  void _onMatchEngineChanged() {
    setState(() {      
          if (_currentMatch != null) {
            _currentMatch.removeListener(_onMatchChanged);
          }

          _currentMatch = widget.matchEngine.currentMatch;
          
          if (_currentMatch != null) {
            _currentMatch.addListener(_onMatchChanged);
          }

          _frontCard = Key(_currentMatch.profile.name);
        });
  }

  void _onMatchChanged() {
    setState(() {
          // current match may have changed state, re-render
        });
  }

  Widget _buildBackCard() {
    return Transform(
      transform: Matrix4.identity()..scale(_nextCardScale, _nextCardScale),
      alignment: Alignment.center,
      child: ProfileCard(
        profile: widget.matchEngine.nextMatch.profile,
      ),
    );
  }

  Widget _buildFrontCard() {
    return ProfileCard(
      key: _frontCard,
      profile: widget.matchEngine.currentMatch.profile,
    );

  }

  SlideDirection _desiredSlideOutDirection() {
    switch(widget.matchEngine.currentMatch.decision) {
      case Decision.nope:
        return SlideDirection.left;
      case Decision.like:
        return SlideDirection.right;
      case Decision.superLike:
        return SlideDirection.up;
      default:
        return null;
    }
  }

  void _onSlideUpdate(double distance) {
    setState(() {
          _nextCardScale = 0.9 + (0.1 * (distance / 100.0).clamp(0.0, 0.1));
        });
  }

  void _onSlideOutComplete(SlideDirection direction) {
    DateMatch currentMatch = widget.matchEngine.currentMatch;

    switch (direction) {
      case SlideDirection.left:
        currentMatch.nope();
        break;
      case SlideDirection.right:
        currentMatch.like();
        break;
      case SlideDirection.up:
        currentMatch.superLike();
        break;
    }

    widget.matchEngine.cycleMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DraggableCard(
          card: _buildBackCard(),
          isDraggable: false,
        ),
        DraggableCard(
          card: _buildFrontCard(),
          onSlideUpdate: _onSlideUpdate,
          onSlideOutComplete: _onSlideOutComplete,
          slideTo: _desiredSlideOutDirection(),
        )
      ],
    );
  }
}

enum SlideDirection {
  left,
  right,
  up,
}

class DraggableCard extends StatefulWidget {

  final Widget card;
  final bool isDraggable;
  final SlideDirection slideTo;
  final Function(double distance) onSlideUpdate;
  final Function(SlideDirection direction) onSlideOutComplete;

  DraggableCard({
    this.card,
    this.isDraggable = true,
    this.slideTo,
    this.onSlideUpdate,
    this.onSlideOutComplete,
  });

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with TickerProviderStateMixin {

  Decision decision;
  GlobalKey profileCardKey = GlobalKey(debugLabel: 'profile_card_key'); // allows us to grab a state object or context of another widget directly
  Offset cardOffset = Offset(0.0, 0.0);
  Offset dragStart;
  Offset dragPosition;
  Offset slideBackStart;
  SlideDirection slideOutDirection;
  AnimationController slideBackAnimation;
  Tween<Offset> slideOutTween;
  AnimationController slideOutAnimation;

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

      if (null != widget.onSlideUpdate) {
        widget.onSlideUpdate(cardOffset.distance);
      }
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

    slideOutAnimation = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    )
    ..addListener(() {
      setState(() {
              cardOffset = slideOutTween.evaluate(slideOutAnimation);

              if (null != widget.onSlideUpdate) {
                widget.onSlideUpdate(cardOffset.distance);
              }
            });
    })
    ..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
                  dragStart = null;
                  slideOutTween = null;
                  dragPosition = null;

                  if (widget.onSlideOutComplete != null) {
                    widget.onSlideOutComplete(slideOutDirection);
                  }
                });
      }
    });
    
  }

  @override
    void didUpdateWidget(DraggableCard oldWidget) {
      // TODO: implement didUpdateWidget
      super.didUpdateWidget(oldWidget);

      if (widget.card.key != oldWidget.card.key) {
        cardOffset = Offset(0.0, 0.0);
      }

      if (oldWidget.slideTo == null && widget.slideTo != null) {
        switch (widget.slideTo) {
          case SlideDirection.left:
            _slideLeft();
            break;
          case SlideDirection.right:
            _slideRight();
            break;
          case SlideDirection.up:
            _slideUp();
            break;
        }
      }
    }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    super.dispose();
  }

  void _slideLeft() async {
    final screenWidth = context.size.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(-2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideRight() async {
    final screenWidth = context.size.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideUp() async {
    final screenHeight = context.size.height;
    dragStart = _chooseRandomDragStart();
    slideOutTween = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -2 * screenHeight));
    slideOutAnimation.forward(from: 0.0);
  }

  Offset _chooseRandomDragStart() {
    final cardContext = profileCardKey.currentContext;
    final cardTopLeft = (cardContext.findRenderObject() as RenderBox).localToGlobal(Offset(0.0, 0.0)); //get the local position in the global coordinates
    final dragStartY = cardContext.size.height * (Random().nextDouble() < 0.5 ? 0.25 : 0.75) + cardTopLeft.dy;

    return Offset(cardContext.size.width / 2 + cardTopLeft.dx, dragStartY);
  }

  void _onPanEnd(DragEndDetails details) {
    //drag vector to see where user is draggin
    final dragVector = cardOffset / cardOffset.distance;
    final isInLeftRegion = (cardOffset.dx / context.size.width) < -0.45;
    final isInRightRegion = (cardOffset.dx / context.size.width) > 0.45;
    final isInTopRegion = (cardOffset.dy / context.size.height).abs() < -0.40;

    setState(() {
          if (isInLeftRegion || isInRightRegion) {
            // just an arbitrary distance, card must exit the screen
            slideOutTween = Tween(begin: cardOffset, end: dragVector * (2 * context.size.width));
            slideOutAnimation.forward(from: 0.0);

            slideOutDirection = isInLeftRegion ? SlideDirection.left : SlideDirection.right;
          } else if (isInTopRegion) {
            slideOutTween = Tween(begin: cardOffset, end: dragVector * (2 * context.size.height));
            slideOutAnimation.forward(from: 0.0);

            slideOutDirection = SlideDirection.up;
          } else {
            slideBackStart = cardOffset;
            slideBackAnimation.forward(from: 0.0);
          }
        });
    
    
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
          dragPosition = details.globalPosition;
          cardOffset = dragPosition - dragStart;
      
          if (null != widget.onSlideUpdate) {
            widget.onSlideUpdate(cardOffset.distance);
          }
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
              key: profileCardKey, //pass global key into this constructor
              width: anchorBounds.width,
              height: anchorBounds.height, // the overlay covers whole page
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                child: widget.card,
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

  final Profile profile;

  ProfileCard({
    Key key,
    this.profile,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  Widget _buildBackground() {
    return PhotoBrowser(
      photoAssetPaths: widget.profile.photos,
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
                    widget.profile.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0
                    ),
                  ),
                  Text(
                    widget.profile.bio,
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
