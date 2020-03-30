import 'package:flutter/foundation.dart';

class SheetRequest {
  final String title;
  final String placeholderOne;
  final String placeholderTwo;
  final int price;
  final String rating;
  final String confirmTitle;
  SheetRequest( {
    @required this.title, 
    this.placeholderOne, 
    this.placeholderTwo, 
    this.price, 
    this.rating,
    @required this.confirmTitle,
  });
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
