import 'package:fluter_demo/http/http.dart';

// 歌手数据层
class UserService {
  static const String rootPath = '/api/user';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 获取列表数据
  static Future getUsers({int page = 1, int limit = 10, String? type}) async {
    final response = await Http.post(listPath,
        data: {'page': page, 'limit': limit, 'type': type});

    Map<String, dynamic> result = response['page'];
    return result;
  }
}
