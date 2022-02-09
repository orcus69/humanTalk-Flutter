import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ConstColors on Color{
  static final orange = Color(0xffFF7A00);
  static final blue = Color(0xff00C2FF);
  static final green = Color(0xff19B200);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}