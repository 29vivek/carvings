import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

BoxDecoration gradientDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Color.fromARGB(100, 51, 71, 158), Colors.black87]
      ));

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
    TextStyle(fontSize: 14, color: Colors.grey[600]);

TextStyle emphasizedMediumStyle = 
    TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w700);

TextStyle disabledMediumStyle = 
    TextStyle(fontSize: 16, color: Colors.grey[500], fontWeight: FontWeight.w700);