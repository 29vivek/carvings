import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/animated_count.dart';
import 'package:carvings/ui/widgets/note_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SheetFood extends StatefulWidget {

  final SheetRequest request;
  final Function(int) onSubmit;
  
  const SheetFood({Key key, this.request, this.onSubmit}) : super(key: key);

  @override
  _SheetFoodState createState() => _SheetFoodState();
}

class _SheetFoodState extends State<SheetFood> {

  int numberOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(widget.request.title, style: subHeaderTextStyle,)
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('₹${widget.request.price}', style: subHeaderTextStyle,),
                ),
              )
            ),
          ],
        ),
        verticalSpaceMedium,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.request.placeholderOne, style: emphasizedMediumStyle),
                  Text(widget.request.placeholderTwo, style: emphasizedMediumStyle),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(icon: FaIcon(FontAwesomeIcons.minus, size: 16), onPressed: () {
                    setState(() {
                      if(numberOfItems > 1)
                        numberOfItems--;
                    });
                  }),
                  AnimatedCount(count: numberOfItems, duration: Duration(milliseconds: 300)),
                  IconButton(icon: FaIcon(FontAwesomeIcons.plus, size: 16), onPressed: () {
                    setState(() {
                      numberOfItems++;
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
        verticalSpaceMedium,
        NoteText(widget.request.rating),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(widget.request.confirmTitle),
              onPressed: () => widget.onSubmit(numberOfItems),
            ),
          ],
        ),
      ],
    );
  }
}