import 'package:fluter_demo/config/app_colors.dart';
import 'package:flutter/material.dart';

class UserType {
  static Map enType = {
    'NORMAL_USER': 'NORMAL_USER',
    'DQ_SINGER': 'DQ_SINGER',
    'DQ_OFFICIAL_ACCOUNT': 'DQ_OFFICIAL_ACCOUNT',
    'ADMIN': 'ADMIN'
  };

  static Map cnType = {
    'NORMAL_USER': '普通用户',
    'DQ_SINGER': '读琴歌手',
    'DQ_OFFICIAL_ACCOUNT': '读琴号',
    'ADMIN': '管理员'
  };

  static Map colorType = {
    'NORMAL_USER': AppColors.unactive,
    'DQ_SINGER': AppColors.info,
    'DQ_OFFICIAL_ACCOUNT': AppColors.success,
    'ADMIN': AppColors.danger,
  };

  static String fromEn(String? type) {
    return enType[type];
  }

  static String fromCn(String? type) {
    return cnType[type] ?? '游客用户';
  }

  static Color fromColor(String? type) {
    return colorType[type] ?? AppColors.unactive;
  }

  // 是否为普通用户
  static bool isNormal(String type) => type == enType['NORMAL_USER'];
  static bool isSinger(String type) => type == enType['DQ_SINGER'];
  static bool isOfficial(String type) => type == enType['DQ_OFFICIAL_ACCOUNT'];
  static bool isAdmin(String type) => type == enType['ADMIN'];
}
