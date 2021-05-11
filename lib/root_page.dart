import 'package:fluter_demo/config/app_colors.dart';
import 'package:fluter_demo/view/root_pages/home_page.dart';
import 'package:fluter_demo/view/root_pages/music_page.dart';
import 'package:fluter_demo/view/root_pages/profile.dart';
import 'package:fluter_demo/view/root_pages/tiny_video.dart';
import 'package:flutter/material.dart';

const Map<String, String> _bottomNames = {
  'home': '首页',
  'music': '音乐',
  'create_media': '',
  'tiny_video': '小视频',
  'profile': '我的'
};

class RootPage extends StatefulWidget {
  RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // 底部bar索引
  int _currentIndex = 0;
  // 底部导航集合
  final List<BottomNavigationBarItem> _bottomNavBarList = [];
  // 页面集合
  final List<Widget> _pages = [
    HomePage(),
    MusicPage(),
    Container(),
    TinyVideoPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // 生成底部导航
    _bottomNames.forEach((key, value) {
      _bottomNavBarList.add(_buttomNavBarItem(key, value));
    });
  }

  //  底部切换
  void _onTabClick(int index) {
    // 发布按钮边缘误触执行
    if (index == 2) {
      return _onCreateMedia();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarList,
        currentIndex: _currentIndex,
        onTap: _onTabClick,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: _createMediaBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 发布按钮点击事件
  void _onCreateMedia() {
    print('_onCreateMedia');
  }

  //  发布按钮
  Widget _createMediaBtn() {
    return Container(
        width: 44,
        height: 44,
        margin: EdgeInsets.only(top: 56),
        child: FloatingActionButton(
          backgroundColor: AppColors.nav,
          child: Image.asset(
            'assets/images/icons/create_media.png',
          ),
          onPressed: _onCreateMedia,
        ));
  }

  // 底部导航每项组件
  BottomNavigationBarItem _buttomNavBarItem(String key, String value) {
    return BottomNavigationBarItem(
        icon:
            Image.asset('assets/images/icons/$key.png', width: 24, height: 24),
        activeIcon: Image.asset('assets/images/icons/${key}_active.png',
            width: 24, height: 24),
        label: value,
        tooltip: '');
  }
}
