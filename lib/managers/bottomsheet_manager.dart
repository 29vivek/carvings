import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/ui/widgets/sheet_content.dart';
import 'package:carvings/ui/widgets/sheet_edit.dart';
import 'package:carvings/ui/widgets/sheet_food.dart';
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
    var isEditSheet = request.rating == null;
    Get.bottomSheet(SheetContent(
          child: isEditSheet 
            ? SheetEdit(
                request: request, 
                onSubmit: (String name, String number) {
                  _bottomSheetService.sheetComplete(SheetResponse(fieldOne: name, fieldTwo: number, confirmed: true));
                }
              )
            : SheetFood(
                request: request,
                onSubmit: (int quantity) {
                  _bottomSheetService.sheetComplete(SheetResponse(number: quantity, confirmed: true));
                },
              )
        ),
        // isScrollControlled: true,
    );
  }

}