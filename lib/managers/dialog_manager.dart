import 'package:carvings/locator.dart';
import 'package:carvings/models/dialog_models.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogManager extends StatefulWidget {

  final Widget child;

  const DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(
      _showDialog
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    Get.defaultDialog(
      title: request.title,
      content: Text(request.description),
      cancel: isConfirmationDialog ? FlatButton(
        child: Text(request.cancelTitle),
        onPressed: () {
          _dialogService.dialogComplete(DialogResponse(confirmed: false));
        },
      ) : null,
      confirm: FlatButton(
        child: Text(request.buttonTitle),
        onPressed: () {
          _dialogService.dialogComplete(DialogResponse(confirmed: true));
        },
      ),
    );
  }
}