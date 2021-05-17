import 'package:flutter/widgets.dart';

// rpx转换
double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}
