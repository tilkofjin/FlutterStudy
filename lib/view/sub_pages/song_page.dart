import 'package:fluter_demo/components/song_card.dart';
import 'package:fluter_demo/models/song_model.dart';
import 'package:fluter_demo/services/song_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>
    with AutomaticKeepAliveClientMixin {
  // 初始化songlist模型
  List<SongItem> _songList = SongList([]).list;
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
    _getSongs();
    _easyRefreshController = EasyRefreshController();
  }

  // 获取数据
  Future _getSongs({bool isPush = false}) async {
    try {
      // 获取数据
      Map<String, dynamic> result = await SongService.getSongs(page: page);
      print(result);
      // 将数据转为实体类
      SongList songListModel = SongList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (isPush) {
          _songList.addAll(songListModel.list);
        } else {
          _songList = songListModel.list;
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
    await _getSongs(isPush: true);
    // 完成刷新
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

// 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getSongs(isPush: true);
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
      child: ListView.builder(
        itemCount: _songList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 8,
              ),
              SongCard(
                songItem: _songList[index],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  // 默认切换使用缓存，不重新请求
  bool get wantKeepAlive => true;
}
