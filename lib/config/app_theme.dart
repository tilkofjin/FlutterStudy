import 'package:fluter_demo/config/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.page, //主题色
    primaryColor: AppColors.primary, //页面背景色
    splashColor: Colors.transparent, //取消水波纹效果
    highlightColor: Colors.transparent, //取消水波纹效果
    indicatorColor: AppColors.active,
    // 未选中样式时的默认文字颜色
    textTheme: TextTheme(bodyText2: TextStyle(color: AppColors.unactive)),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.nav,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
        unselectedLabelColor: AppColors.unactive,
        indicatorSize: TabBarIndicatorSize.label, //  滑块大小根据文字来定
        labelStyle: TextStyle(
          //选中时滑块的文字大小
          fontSize: 18,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 12)),
    //底部按钮
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.nav,
        selectedItemColor: AppColors.active,
        unselectedItemColor: AppColors.unactive,
        selectedLabelStyle: TextStyle(fontSize: 12)));
