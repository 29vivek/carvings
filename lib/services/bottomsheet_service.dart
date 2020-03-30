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
    _showSheetListener(SheetRequest(
      title: title,
      placeholderOne: placeholderOne,
      placeholderTwo: placeholderTwo,
      confirmTitle: confirmTitle,
    ));
    return _sheetCompleter.future;
  }

  Future<SheetResponse> showFoodSheet({
    String title,
    String subtitle,
    String description,
    int price = 0,
    String rating = '0 stars based on 0 ratings.',
    String confirmTitle = 'Add To Cart',
  }) {
    _sheetCompleter = Completer<SheetResponse>();
    _showSheetListener(SheetRequest(
      title: title,
      placeholderOne: subtitle,
      placeholderTwo: description,
      price: price,
      rating: rating,
      confirmTitle: confirmTitle,
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