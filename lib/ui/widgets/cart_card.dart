import 'package:carvings/models/cart_item.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/animated_count.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'note_text.dart';

class CartCard extends StatefulWidget {

  final CartItem item;
  final bool isCartItem;

  // So the idea is on increment/decrement, update the table in the database. (UI just do increments in the total cost)
  // when order is placed, yeet the entire table, after sending required values to the server.
  final Function(int) onChanged;

  const CartCard({Key key, this.item, this.isCartItem, this.onChanged}) : super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {

  int numberOfItems = 1;

  @override
  void initState() {
    numberOfItems = widget.item.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: fieldDecoration,
      padding: massiveFieldPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.item.foodName, style: emphasizedMediumStyle,),
                verticalSpaceSmall,
                NoteText(widget.item.canteeenName),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(icon: FaIcon(FontAwesomeIcons.minus, size: 16), onPressed: () {
                  setState(() {
                    if(numberOfItems > 1)
                      numberOfItems--;
                  });
                  widget.onChanged(numberOfItems);
                }),
                AnimatedCount(count: numberOfItems, duration: Duration(milliseconds: 300)),
                IconButton(icon: FaIcon(FontAwesomeIcons.plus, size: 16), onPressed: () {
                  setState(() {
                    numberOfItems++;
                  });
                  widget.onChanged(numberOfItems);
                }),
              ],
            ),
          ),
          Flexible(
            flex: 1, 
            fit: FlexFit.tight,
            child: Text('₹${widget.item.price * numberOfItems}')
          ),
        ],  
      ),
    );
  }
}