import 'package:fluter_demo/components/article_card.dart';
import 'package:fluter_demo/components/song_card.dart';
import 'package:fluter_demo/components/video_card.dart';
import 'package:fluter_demo/models/article_model.dart';
import 'package:fluter_demo/models/recommend_interface.dart';
import 'package:fluter_demo/models/song_model.dart';
import 'package:fluter_demo/models/video_model.dart';
import 'package:fluter_demo/services/recommend_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key? key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  // 初始化songlist模型
  List<RecommendInterface> _recommendList = [];
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
    _getRecommends();
    _easyRefreshController = EasyRefreshController();
  }

  // 获取数据
  Future _getRecommends({bool isPush = false}) async {
    try {
      // 获取数据
      List<dynamic> result = await RecommendService.getRecommends(page: page);
      List<RecommendInterface> recommendList = result
          .map((item) {
            if (item['songEntity'] != null) {
              return SongItem.fromJson(item['songEntity']);
            } else if (item['articleEntity'] != null) {
              return ArticleItem.fromJson(item['articleEntity']);
            } else if (item['videoEntity'] != null) {
              return VideoItem.fromJson(item['videoEntity']);
            }
          })
          .takeWhile((val) => val != null)
          .toList()
          .cast<RecommendInterface>();
      print('recommendList-------------->$recommendList');
      setState(() {
        page++;
        if (isPush) {
          _recommendList.addAll(recommendList);
        } else {
          _recommendList = recommendList;
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
    await _getRecommends();
    // 完成刷新
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

// 上拉加载
  Future _onLoad() async {
    await _getRecommends(isPush: true);
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
      child: ListView.builder(
        itemCount: _recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          RecommendInterface? widgetItem = _recommendList[index];
          return getWidgetByInterface(widgetItem);
        },
      ),
    );
  }

  Widget getWidgetByInterface(RecommendInterface widgetItem) {
    if (widgetItem is SongItem) {
      return cloumnBox(SongCard(
        songItem: widgetItem,
      ));
    } else if (widgetItem is ArticleItem) {
      return cloumnBox(ArticleCard(
        articleItem: widgetItem,
      ));
    } else if (widgetItem is VideoItem) {
      return cloumnBox(VideoCard(
        videoItem: widgetItem,
      ));
    } else {
      return SizedBox.shrink(); // 空组件，且不占位
    }
  }

  Widget cloumnBox(Widget card) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        card,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
