import 'package:fluter_demo/models/recommend_interface.dart';
import 'package:fluter_demo/models/user_model.dart';
import 'user_model.dart';

//  文章列表模型
class ArticleList {
  // 包含 ArticleList 模型的集合
  List<ArticleItem> list;

  ArticleList(this.list);
  // 循环后台返回的数据，将每项数据组装成 ArticleItem
  factory ArticleList.fromJson(List<dynamic> list) {
    return ArticleList(list.map((item) => ArticleItem.fromJson(item)).toList());
  }
}

// 文章每项 - 详情模型
class ArticleItem implements RecommendInterface {
  final int id;
  final int userId;
  final List coverUrlList;
  final String title;
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  final UserItem user;

  ArticleItem({
    required this.id,
    required this.userId,
    required this.coverUrlList,
    required this.title,
    required this.commentCount,
    required this.thumbUpCount,
    required this.readCount,
    required this.user,
  });

  // 将 json 数据转化为实体类
  factory ArticleItem.fromJson(dynamic item) {
    return ArticleItem(
        id: item['id'],
        userId: item['userId'],
        coverUrlList: item['coverUrlList'],
        title: item['title'],
        commentCount: item['commentCount'],
        thumbUpCount: item['thumbUpCount'],
        readCount: item['readCount'],
        user: UserItem.fromJson(item['user']));
  }
}
