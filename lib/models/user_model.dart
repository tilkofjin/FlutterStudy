// 用户列表每项和详情模型
class UserItem {
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
        musicPlayCount: item['musicPlayCount']);
  }
}
