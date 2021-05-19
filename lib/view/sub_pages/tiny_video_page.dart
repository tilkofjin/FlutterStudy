import 'package:fluter_demo/components/tiny_video_card.dart';
import 'package:fluter_demo/models/video_model.dart';
import 'package:fluter_demo/services/video_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class TinyVideoPage extends StatefulWidget {
  TinyVideoPage({Key? key}) : super(key: key);

  @override
  _TinyVideoPageState createState() => _TinyVideoPageState();
}

class _TinyVideoPageState extends State<TinyVideoPage>
    with AutomaticKeepAliveClientMixin {
  // 初始化 userList 模型
  List<VideoItem> _videoList = VideoList([]).list;
  late EasyRefreshController _easyRefreshController;

  int page = 1;
  int limit = 10;
  bool hasMore = true;
  bool error = false;
  bool loading = true;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    _getVideos();
  }

  // 获取数据
  Future _getVideos({bool isPush = false}) async {
    try {
      // 获取数据
      Map<String, dynamic> result = await VideoService.getVideos(page: page);
      print(result);
      // 将数据转为实体类
      VideoList videoListModel = VideoList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (isPush) {
          _videoList.addAll(videoListModel.list);
        } else {
          _videoList = videoListModel.list;
        }
      });
    } catch (err) {
      setState(() {
        error = true;
        errorMsg = err.toString();
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  // 下拉刷新
  Future _onRefresh() async {
    page = 1;
    await _getVideos(isPush: true);
    // 完成刷新
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

// 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getVideos(isPush: true);
    }
    // 完成加载
    _easyRefreshController.finishLoad(noMore: !hasMore);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      controller: _easyRefreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
        itemCount: _videoList.length,
        padding: EdgeInsets.only(top: 8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8, //上下间距
          crossAxisSpacing: 1, //左右间距
          childAspectRatio: 1 / 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          bool isEven = index.isEven;
          double pl = isEven ? 18 : 9;
          double pr = isEven ? 9 : 18;
          return Container(
            padding: EdgeInsets.only(top: 10, left: pl, right: pr),
            color: Colors.white,
            child: TinyVideoCard(
              videoItem: _videoList[index],
            ),
          );
        });
  }

  @override
  // 默认切换使用缓存，不重新请求
  bool get wantKeepAlive => true;
}
