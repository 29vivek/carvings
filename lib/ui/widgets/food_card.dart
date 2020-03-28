import 'package:carvings/models/food.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {

  final Food food;
  final Function onPressed;

  FoodCard(this.food, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: gradientDecoration,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NoteText(food.name, color: Colors.white60,),
              NoteText(food.canteenName, color: Colors.white70,),
              NoteText(food.price.toString(), color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}