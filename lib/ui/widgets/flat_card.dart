import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlatCard extends StatefulWidget {
  
  final String title;
  final String description;
  final Function onPressed;
  const FlatCard({
    Key key, 
    this.title, 
    this.description,
    this.onPressed,
  }) : super(key: key);

  @override
  _FlatCardState createState() => _FlatCardState();
}

class _FlatCardState extends State<FlatCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: fieldDecoration,
        child: InkWell(
          onTap: widget.onPressed,
          child: Padding(
            padding: massiveFieldPadding,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.title, style: subHeaderTextStyle),
                      verticalSpaceMedium,
                      Text(widget.description, style: infoTextStyle),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.angleRight,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}