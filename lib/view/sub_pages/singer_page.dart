import 'package:fluter_demo/components/singer_card.dart';
import 'package:fluter_demo/models/user_model.dart';
import 'package:fluter_demo/services/user_service.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class SingerPage extends StatefulWidget {
  SingerPage({Key? key}) : super(key: key);

  @override
  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage>
    with AutomaticKeepAliveClientMixin {
  // 初始化 userList 模型
  List<UserItem> _singerList = UserList([]).list;
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
    _getUsers();
  }

  // 获取数据
  Future _getUsers({bool isPush = false}) async {
    try {
      // 获取数据
      Map<String, dynamic> result = await UserService.getUsers(page: page);
      print(result);
      // 将数据转为实体类
      UserList userListModel = UserList.fromJson(result['data']);
      setState(() {
        hasMore = page * limit < result['total'];
        page++;
        if (isPush) {
          _singerList.addAll(userListModel.list);
        } else {
          _singerList = userListModel.list;
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
    await _getUsers(isPush: true);
    // 完成刷新
    _easyRefreshController.finishRefresh();
    // 重置加载状态
    _easyRefreshController.resetLoadState();
  }

// 上拉加载
  Future _onLoad() async {
    if (hasMore) {
      await _getUsers(isPush: true);
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
        itemCount: _singerList.length,
        padding: EdgeInsets.only(top: 8),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: MediaQuery.of(context).size.width / 1.5,
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          bool isEven = index.isEven;
          double pl = isEven ? 18 : 9;
          double pr = isEven ? 9 : 18;
          return Container(
            padding: EdgeInsets.only(top: 10, left: pl, right: pr),
            color: Colors.white,
            child: SingerCard(
              coverPictureUrl: _singerList[index].coverPictureUrl,
              nickname: _singerList[index].nickname,
              musicCount: _singerList[index].musicCount,
              musicPlayCount: _singerList[index].musicCount,
            ),
          );
        });
  }

  @override
  // 默认切换使用缓存，不重新请求
  bool get wantKeepAlive => true;
}
