import 'package:flutter/material.dart';

class Dimens {
  const Dimens._();

  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const smd = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
  static const xxxl = 64.0;

  static EdgeInsets system(BuildContext context) => MediaQuery.of(context).padding;

  static const animationDuration = Duration(milliseconds: 200);
  static const appBarHeight = 56.0;
  static const homeCardHeight = 115.0;
}
