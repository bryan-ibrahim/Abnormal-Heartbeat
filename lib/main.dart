import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: PlayingWithAnimations(),
      debugShowCheckedModeBanner: false,
    ));

class PlayingWithAnimations extends StatefulWidget {
  @override
  _PlayingWithAnimationsState createState() => _PlayingWithAnimationsState();
}

class _PlayingWithAnimationsState extends State<PlayingWithAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animationController.value = 0.2;
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.bounceOut);
    animation.addListener(() {
      this.setState(() {});
    });
    animation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {//To reverse the animation after completion
        animationController.animateBack(0.2,duration: Duration(seconds: 2),curve: Curves.bounceOut);
      } else if (status == AnimationStatus.dismissed) {//To forward the animation after reverse completion
        animationController.animateTo(1,duration: Duration(seconds:2),curve: Curves.bounceIn);
      }
    });
//    animationController.forward();
    animationController.animateTo(1,duration: Duration(seconds:2),curve: Curves.bounceIn);

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.lightBlue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: animation.value * 200,
            )
          ],
        ),
      ),
    );
  }
}
