import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/widgets/busy_button.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:flutter/widgets.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';

class FormList extends StatefulWidget {
  
  final List<InputField> editables;
  final List<String> nonEditables;
  final String title;
  final BusyButton button;

  const FormList({
    Key key, 
    this.editables,
    this.nonEditables, 
    this.title,
    this.button,
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _FormListState();

}

class _FormListState extends State<FormList> {
  
  List<Widget> _nonEditableTexts = [];
  List<Widget> _editableTexts = [];

  @override
  void initState() {

    widget.nonEditables.forEach((String s) {
      _nonEditableTexts.add(
        Column(
          children: <Widget>[
            Text(s, style: TextStyle(fontSize: 15)),
            verticalSpaceSmall,
          ],
        )
      );
    });

    widget.editables.forEach((InputField f) {
      _editableTexts.add(
        Column(
          children: <Widget>[
            f,
            verticalSpaceSmall,
          ],
        )
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.title, style: subHeaderTextStyle,),
        verticalSpaceMedium,
        ..._nonEditableTexts,
        ..._editableTexts,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            widget.button,
          ],
        )
      ],      
    );
  }


}