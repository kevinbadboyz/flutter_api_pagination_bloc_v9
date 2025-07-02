import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apli_bloc_pagination_v9/core/api_client.dart';
import 'package:flutter_apli_bloc_pagination_v9/models/post_model.dart';

class PostRepository extends ApiClient {
  Future<List<PostModel>> getPosts(int _offset, int _limit) async {
    try {
      final response = await dio.get(
        'posts?_start=${_offset}&_limit=${_limit}',
      );
      debugPrint('PostModel GET ALL : ${response.data}');
      List list = response.data;
      List<PostModel> listPostModel = list
          .map((elemet) => PostModel.fromJson(elemet))
          .toList();
      return listPostModel;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
