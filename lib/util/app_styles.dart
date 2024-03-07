import 'package:flutter/material.dart';
import 'package:smart_home/util/app_fontsizes.dart';

class AppStyle{

  static const TextStyle titleStyle = TextStyle(
    fontSize: AppFontSize.titleFontSize,
    fontWeight: FontWeight.bold
  );

  static const TextStyle roomLabelStyle = TextStyle(
    fontSize: AppFontSize.subtitleFontSize,
    fontWeight: FontWeight.bold
  );

  static const TextStyle deviceCountLabelStyle = TextStyle(
    fontSize: AppFontSize.normalFontSize,
    fontWeight: FontWeight.w400,
    color: Colors.grey
  );

  static const TextStyle sensorDataStyle = TextStyle(
    fontSize: AppFontSize.subtitleFontSize,
    fontWeight: FontWeight.w500,
  );

}