import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class LoadingCard extends StatefulWidget {
  
  @override
  _LoadingCardState createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  Animation _opacityAnimation;
  
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _opacityAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller)
      ..addListener(
        () => setState(() {})
      );
    _animateForward();
    super.initState();
  }

  void _animateForward() {
    _controller.forward().then(
      (_) => _animateReverse()
    );
  }

  void _animateReverse() {
    _controller.reverse().then(
      (_) => _animateForward()
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: fieldDecoration,
      padding: massiveFieldPadding,
      width: screenWidthFraction(context, dividedBy: 0.75),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 22.0,
            decoration: BoxDecoration(color: Colors.grey[350].withOpacity(_opacityAnimation.value), borderRadius: BorderRadius.circular(5)),
          ),
          verticalSpaceMedium,
          Container(
            height: 14.0,
            decoration: BoxDecoration(color: Colors.grey[300].withOpacity(_opacityAnimation.value), borderRadius: BorderRadius.circular(5)),
          ),
          verticalSpaceTiny,
          Container(
            height: 14.0,
            decoration: BoxDecoration(color: Colors.grey[300].withOpacity(_opacityAnimation.value), borderRadius: BorderRadius.circular(5)),
          ),
          verticalSpaceTiny,
          Container(
            height: 14.0,
            decoration: BoxDecoration(color: Colors.grey[300].withOpacity(_opacityAnimation.value), borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}