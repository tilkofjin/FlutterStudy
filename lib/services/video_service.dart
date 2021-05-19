import 'package:fluter_demo/http/http.dart';

// 小视频数据层
class VideoService {
  static const String rootPath = '/api/video';
  static const String listPath = '$rootPath/list';
  static const String infoPath = '$rootPath/info';

  // 获取列表数据
  static Future getVideos({int page = 1, int limit = 10, String? type}) async {
    final response = await Http.post(listPath,
        data: {'page': page, 'limit': limit, 'type': type});

    Map<String, dynamic> result = response['page'];
    return result;
  }
}
