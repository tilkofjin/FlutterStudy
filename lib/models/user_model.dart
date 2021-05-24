// 用户列表模型
import 'package:fluter_demo/models/recommend_interface.dart';

class UserList {
  // 包含 SongList 模型的集合
  final List<UserItem> list;

  UserList(this.list);

  // 循环后台返回的数据，将每项数据组装成 UserItem
  factory UserList.fromJson(List<dynamic> list) {
    return UserList(list.map((item) => UserItem.fromJson(item)).toList());
  }
}

class UserItem implements RecommendInterface {
  final int id;
  final String coverPictureUrl;
  final String nickname;
  final String type;
  final int musicCount;
  final int musicPlayCount;

  UserItem({
    required this.id,
    required this.coverPictureUrl,
    required this.nickname,
    required this.type,
    required this.musicCount,
    required this.musicPlayCount,
  });

  // 转换成实体类
  factory UserItem.fromJson(dynamic item) {
    return UserItem(
        id: item['id'],
        coverPictureUrl: item['coverPictureUrl'],
        nickname: item['nickname'],
        type: item['type'],
        musicCount: item['musicCount'],
        musicPlayCount: item['musicPlayCount']); //UserItem
  }
}
