import 'package:fluter_demo/http/http.dart';

// 文章数据层
class RecommendService {
  static const String rootPath = '/api/recommend';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 获取列表数据
  static Future getRecommends({int page = 1, int limit = 10}) async {
    final response =
        await Http.post(listPath, data: {'page': page, 'limit': limit});

    List<dynamic> result = response['page'];
    return result;
  }
}
