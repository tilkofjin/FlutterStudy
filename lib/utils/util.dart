import 'dart:math';
import 'package:flutter/widgets.dart';

// rpx转换
double toRpx(BuildContext context, double size) {
  double rpx = MediaQuery.of(context).size.width / 750;
  return size * rpx;
}

String formatCharCount(int count) {
  if (count <= 0 || count.isNaN) {
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

// 随机获取指定范围内的值
int getRandomRangeInt(int min, int max) {
  final Random random = new Random();
  return min + random.nextInt(max + 1 - min);
}

// 时间转换为时分秒
String getDurationTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0"); // 字符串是否为 2 位，不够向左补 0
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
