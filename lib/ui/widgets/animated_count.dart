import 'package:flutter/widgets.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;

  AnimatedCount({
    Key key,
    @required this.count,
    @required Duration duration,
    Curve curve = Curves.ease
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(_count.evaluate(animation).toString());
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(_count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}