import 'package:flutter/widgets.dart';

extension SizedBoxExtensiton on num{
  SizedBox get hight => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
