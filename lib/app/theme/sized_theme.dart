import 'package:flutter/material.dart';

const double defaultMargins = 24;
const double defaultMarginn = 30;
double defaultWidth(BuildContext context) =>
    deviceWidth(context) - 2 * defaultMarginn;
double defaultHeight(BuildContext context) =>
    deviceHeight(context) - 2 * defaultMarginn;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double statusBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top;

class PaddingCustom {
  paddingAll(double value) {
    return EdgeInsets.all(value);
  }

  paddingHorizontalVertical(double horizontal, double vertical) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  paddingHorizontal(double horizontal) {
    return EdgeInsets.symmetric(horizontal: horizontal);
  }

  paddingVertical(double vertical) {
    return EdgeInsets.symmetric(vertical: vertical);
  }

  paddingOnly(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
  }
}
