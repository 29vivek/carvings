import 'package:carvings/models/food.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/ui/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {

  final Food food;
  final Function onPressed;
  final Function onLongPressed;
  final Function onDoubleTap;

  FoodCard({@required this.food, this.onPressed, this.onLongPressed, this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: Ink(
        decoration: food.availability ? fieldDecoration : disabledFieldDecoration,
        child: InkWell(
          onLongPress: onLongPressed,
          onTap: food.availability ? onPressed : null,
          onDoubleTap: onDoubleTap,
          child: Padding(
            padding: largeFieldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 3, 
                  fit: FlexFit.tight,
                  child: Text(food.name, style: food.availability ? emphasizedMediumStyle : disabledMediumStyle, overflow: TextOverflow.ellipsis, maxLines: 2,)
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: NoteText(food.canteenName),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight, 
                  child: Text('₹${food.price}', style: food.availability ? emphasizedMediumStyle : disabledMediumStyle,)
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight, 
                  child: StarRating(rating: food.rating, onRatingChanged: (i) => print(i),)
                ),
                Flexible(
                  flex: 1, 
                  fit: FlexFit.tight,
                  child: NoteText('based on ${food.numberRatings} ratings.')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}