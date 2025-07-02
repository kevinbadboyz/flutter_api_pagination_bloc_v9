import 'package:dio/dio.dart';

abstract class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.baseUrl =
        'https://jsonplaceholder.typicode.com/';
  }

  Dio get dio => _dio;
}
