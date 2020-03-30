import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';

class SheetEdit extends StatefulWidget {

  final SheetRequest request;
  final Function(String, String) onSubmit;

  const SheetEdit({Key key, this.request, this.onSubmit}) : super(key: key);

  @override
  _SheetEditState createState() => _SheetEditState();
}

class _SheetEditState extends State<SheetEdit> {

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.request.title, style: subHeaderTextStyle,),
        verticalSpaceMedium,
        if(widget.request.placeholderOne != null)
          InputField(controller: _nameController, placeholder: widget.request.placeholderOne),
        if(widget.request.placeholderTwo != null)
          InputField(controller: _numberController, placeholder: widget.request.placeholderTwo, textInputType: TextInputType.number,),
        verticalSpaceMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text(widget.request.confirmTitle),
              onPressed: () => widget.onSubmit(_nameController.text, _numberController.text),
            ),
          ],
        ),
      ],
    );
  }
}