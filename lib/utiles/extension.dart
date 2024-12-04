import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringExtension on String {
  toUpperLowerCase(){
    return  isEmpty ? "" : this[0].toUpperCase() + substring(1,length);
  }

  Widget toSvgImage({double? width, double? height,Color? color}) {
    return SvgPicture.asset(
      this,
      colorFilter:color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}


