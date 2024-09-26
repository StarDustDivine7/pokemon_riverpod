import 'package:dio/dio.dart';

class HttpServices {
  HttpServices();
  final _dio = Dio();
// That api only get function is avalabel so do that now

  Future<Response?> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
