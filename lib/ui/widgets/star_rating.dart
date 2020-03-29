import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StarRating extends StatelessWidget {

  final int starCount;
  final num rating;
  final Function(num) onRatingChanged;
  final Color color;

  const StarRating({Key key, this.starCount = 5, @required this.rating, this.onRatingChanged, this.color}) : super(key: key);

  Widget _buildStar(int starNumber) {
    FaIcon icon;
    if(starNumber <= rating)
      icon = FaIcon(FontAwesomeIcons.solidStar, color: color ?? Color(0xffffcc201), size: 16,); 
    else if(starNumber > rating && starNumber  < rating + 1)
      icon = FaIcon(FontAwesomeIcons.starHalfAlt, color: color ?? Color(0xffffcc201), size: 16);
    else
      icon = FaIcon(FontAwesomeIcons.star, color: color ?? Color(0xffffcc201), size: 16,);
    return GestureDetector(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(starNumber),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: icon,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (i) => _buildStar(i+1)),
    );
  }
}