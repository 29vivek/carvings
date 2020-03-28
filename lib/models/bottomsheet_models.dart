import 'package:flutter/foundation.dart';

class SheetRequest {

}

class SheetEdit extends SheetRequest{
  final String title;
  final String placeholderOne;
  final String placeholderTwo;
  final String confirmTitle;

  SheetEdit({
    @required this.title, 
    this.placeholderOne, 
    this.placeholderTwo, 
    @required this.confirmTitle
  });
}

class SheetFood extends SheetRequest {
  
}

class SheetResponse {
  final String fieldOne;
  final String fieldTwo;
  final int number;
  final bool confirmed;

  SheetResponse({
    this.fieldOne,
    this.fieldTwo,
    this.number,
    this.confirmed,
  });
}
