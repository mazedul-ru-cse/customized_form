import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Responsive{

  BuildContext context;
  static late double height;
  static late double width;
  static late bool margin;

  Responsive(this.context){

    if(defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS){
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
      margin = false;

    }else if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS){

        height = MediaQuery.of(context).size.height*0.95;
        width = MediaQuery.of(context).size.height*0.8;
        margin = true;
    }
  }

   double getHeight() {
    return height;
  }

  double getWidth() {
    return width;
  }

  bool getMargin() {
    return margin;
  }

}