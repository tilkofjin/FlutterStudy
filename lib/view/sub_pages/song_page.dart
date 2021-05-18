import 'package:fluter_demo/components/song_card.dart';
import 'package:fluter_demo/models/song_model.dart';
import 'package:fluter_demo/services/song_service.dart';
import 'package:flutter/material.dart';

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  // 初始化songlist模型
  List<SongItem> _songList = SongList([]).list;

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
          _songList = songListModel.list;
        } else {
          _songList.addAll(songListModel.list);
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
