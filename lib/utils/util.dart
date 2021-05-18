import 'package:flutter/widgets.dart';

// rpx转换
double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}

String formatCharCount(int count) {
  if (count == null || count <= 0 || count.isNaN) {
    return '0';
  }
  String strCount = count.toString();
  if (strCount.length >= 5) {
    // 多取 1 位再进行截取，防止第二位四舍五。
    String preFix = (count / 10000).toStringAsFixed(3);
    preFix = preFix.substring(0, preFix.lastIndexOf('.') + 3) + 'w';
    return preFix;
  }
  return strCount;
}
