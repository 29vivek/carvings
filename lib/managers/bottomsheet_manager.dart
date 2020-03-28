import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/ui/shared/shared_styles.dart';
import 'package:carvings/ui/shared/ui_helpers.dart';
import 'package:carvings/ui/widgets/input_field.dart';
import 'package:carvings/ui/widgets/sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetManager extends StatefulWidget {

  final Widget child;

  const BottomSheetManager({Key key, this.child}) : super(key: key);

  @override
  _BottomSheetManagerState createState() => _BottomSheetManagerState();
}

class _BottomSheetManagerState extends State<BottomSheetManager> {

  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    _bottomSheetService.registerSheetListener(
      _showSheet
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showSheet(SheetRequest request) {
    if(request is SheetEdit) {
      Get.bottomSheet(
        builder: (context) {
          return SheetContent(
            child: Column(
              children: <Widget>[
                Text(request.title, style: subHeaderTextStyle,),
                verticalSpaceMedium,
                if(request.placeholderOne != null)
                  InputField(controller: _nameController, placeholder: request.placeholderOne),
                if(request.placeholderTwo != null)
                  InputField(controller: _numberController, placeholder: request.placeholderTwo, textInputType: TextInputType.number,),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(request.confirmTitle),
                      onPressed: () {
                        _bottomSheetService.sheetComplete(SheetResponse(fieldOne: _nameController.text, fieldTwo: _numberController.text, confirmed: true));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

}