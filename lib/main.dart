import 'package:fluter_demo/transit_page.dart';
import 'package:flutter/material.dart';

import 'config/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData,
        title: '读琴',
        debugShowCheckedModeBanner: false,
        home: TransitPage());
  }
}
