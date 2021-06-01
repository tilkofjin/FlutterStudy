import 'package:fluter_demo/components/root_page_head.dart';
import 'package:fluter_demo/view/sub_pages/singer_page.dart';
import 'package:fluter_demo/view/sub_pages/song_page.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

const List<Tab> _tabs = [
  Tab(
    text: '歌曲',
  ),
  Tab(
    text: '推荐',
  ),
];

final List<Widget> _tabsContent = [
  SongPage(),
  SingerPage(),
];

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  //使用 TabController 需要 with TickerProviderStateMixin
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // implement dispose
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RootPageHead(),
        bottom: TabBar(
          tabs: _tabs,
          isScrollable: true, //内容太多滚动
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: _tabsContent,
        controller: _tabController,
      ),
    );
  }
}
