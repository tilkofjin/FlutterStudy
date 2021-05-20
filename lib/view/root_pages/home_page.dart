import 'package:fluter_demo/components/root_page_head.dart';
import 'package:fluter_demo/view/sub_pages/article_page.dart';
import 'package:fluter_demo/view/sub_pages/singer_page.dart';
import 'package:fluter_demo/view/sub_pages/song_page.dart';
import 'package:fluter_demo/view/sub_pages/tiny_video_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const List<Tab> _tabs = [
  Tab(
    text: '歌曲',
  ),
  Tab(
    text: '推荐',
  ),
  Tab(
    text: '歌手',
  ),
  Tab(
    text: '小视频',
  ),
  Tab(
    text: '文章',
  ),
  Tab(
    text: '视频',
  ),
];

final List<Widget> _tabsContent = [
  SongPage(),
  Text('datadata'),
  SingerPage(),
  TinyVideoPage(),
  ArticlePage(),
  Text('datadata')
];

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //使用 TabController 需要 with TickerProviderStateMixin
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 1, length: _tabs.length, vsync: this);

    // 监听切换tab
    // _tabController.addListener(() {
    //   _tabController.index;
    // });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
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
