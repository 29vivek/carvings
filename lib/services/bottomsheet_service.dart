import 'dart:async';

import 'package:carvings/models/bottomsheet_models.dart';
import 'package:get/get.dart';

class BottomSheetService {
  Function(SheetRequest) _showSheetListener;
  Completer<SheetResponse> _sheetCompleter;

  void registerSheetListener(Function(SheetRequest) showSheetListener) {
    _showSheetListener = showSheetListener;
  }

  /// Calls the sheet listener and returns a Future that will wait for sheetComplete.
  Future<SheetResponse> showEditSheet({
    String title,
    String placeholderOne,
    String placeholderTwo,
    String confirmTitle = 'Done',
  }) {
    _sheetCompleter = Completer<SheetResponse>();
    _showSheetListener(SheetEdit(
      title: title,
      placeholderOne: placeholderOne,
      placeholderTwo: placeholderTwo,
      confirmTitle: confirmTitle,
    ));
    return _sheetCompleter.future;
  }

  Future<SheetResponse> showFoodSheet() {
    _sheetCompleter = Completer<SheetResponse>();
    _showSheetListener(SheetFood(
      
    ));
    return _sheetCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void sheetComplete(SheetResponse response) {
    Get.back();
    _sheetCompleter.complete(response);
    _sheetCompleter = null;
  }

}