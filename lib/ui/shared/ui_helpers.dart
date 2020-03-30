import 'package:flutter/material.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

Widget topSpacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {double dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {double dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double thirdScreenHeight(BuildContext context) =>
    screenHeightFraction(context, dividedBy: 3);

EdgeInsets defaultPadding(context) =>  EdgeInsets.symmetric(
      horizontal: twelfthScreenWidth(context),
      vertical: screenWidthFraction(context, dividedBy: 15),
    );

double twelfthScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 12);

// i guess some more insight could be put into this
double smartAspectRatio(BuildContext context) {
  var ratio = MediaQuery.of(context).devicePixelRatio;
  return ratio < 2 ? 1.25 : ratio > 3 ? 0.75 : 1.25-(ratio-2)*0.5;
}