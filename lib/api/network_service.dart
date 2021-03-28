import 'dart:convert';

import 'package:demo_fllutter_cmdev/api/post_data.dart';
import 'package:dio/dio.dart';

class NetworkService {
  NetworkService._internal();
  // # Singleton
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio();

  Future<List<Post>> fatchPosts(int startIndex, {int limit = 10}) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';

    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    } else {
      throw Exception('Network failled');
    }
  }
}
