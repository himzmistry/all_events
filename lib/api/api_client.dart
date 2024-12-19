import 'package:all_events/model/category/category_model.dart';
import 'package:dio/dio.dart';

class APIClient {
  final Dio _dio = Dio();

  Future<Response?> getHttp(String url, {String? customUrl}) async {
    try {
      // BaseOptions options = BaseOptions(
      //   baseUrl: 'https://reqres.in/api/',
      //   headers: {
      //     "Content-Type": 'application/json',
      //   },
      // );
      print('url: $url');
      Response response = await _dio.get(customUrl ?? url);
      print('response: $response');
      return response;
    } catch (e) {
      print('fetchUserInfo: $e');
    }
  }
}
