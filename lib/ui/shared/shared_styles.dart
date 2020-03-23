import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);
const EdgeInsets massiveFieldPadding = 
    const EdgeInsets.symmetric(horizontal: 20, vertical: 20);

// Text Variables
const TextStyle buttonTitleTextStyle =
    const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);

const TextStyle headerTextStyle = 
    const TextStyle(fontSize: 38, color: Colors.black);

const TextStyle subHeaderTextStyle = 
    const TextStyle(fontSize: 22, color: Colors.black87);

TextStyle infoTextStyle = 
    TextStyle(fontSize: 15, color: Colors.grey[600]);