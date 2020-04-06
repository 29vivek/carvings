import 'package:carvings/models/order.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:carvings/ui/widgets/star_rating.dart';
import 'package:carvings/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {

  final Order order;
  final Function(int, int) onRating;
  final Function onComplete;

  const OrderCard({Key key, this.order, this.onRating, this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: fieldDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: massiveFieldPadding,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Order ID: ${order.orderId}', style: emphasizedMediumStyle,),
                            Text('placed on ${order.when}', style: infoTextStyle,),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('₹${order.total}', style: emphasizedMediumStyle,),
                          Text('${order.status}', style: infoTextStyle.copyWith(color: Colors.green),),
                        ],
                      )
                    ],
                  ),
                  smallSpacedDivider,
                  ListView.separated(
                    separatorBuilder: (_, i) => verticalSpaceSmall,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i ) => OrderItemCard(item: order.items[i], onRating: onRating,),
                    itemCount: order.items.length,
                  ),
                  if(onComplete != null && order.status == 'Processing')
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        smallSpacedDivider,
                        TextLink('Complete this order', onPressed: onComplete,)
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderItemCard extends StatefulWidget {

  final OrderItem item;
  final Function(int, int) onRating;

  const OrderItemCard({Key key, this.item, this.onRating}) : super(key: key);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {

  int rating;

  @override
  void initState() {
    rating = widget.item.didRateFood;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${widget.item.foodName}', style: emphasizedMediumStyle,),
              verticalSpaceTiny,
              NoteText('${widget.item.canteenName}'),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('₹${widget.item.price} * ${widget.item.quantity} = ₹${widget.item.price * widget.item.quantity}', style: infoTextStyle,),
            verticalSpaceTiny,
            widget.onRating != null
            ? rating != 0 
            ? NoteText('you rated $rating stars.')
            : StarRating(
                rating: widget.item.didRateFood,
                onRatingChanged: rating == 0 ? (newRating) {
                  setState(() {
                    rating = newRating;
                  });
                  widget.onRating(widget.item.orderItemId, newRating);
                } : null,
              )
            : Container(), // empty container for admins
          ],
        )
      ],
    );
  }
}