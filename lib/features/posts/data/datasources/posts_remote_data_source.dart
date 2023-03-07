// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/utils/constants/base_url.dart';
import 'package:task/core/utils/helpers/decode_response.dart';
import 'package:task/features/posts/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<int> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int id);
}

class PostsRemoteWithHttp implements PostsRemoteDataSource {
  final http.Client client;
  PostsRemoteWithHttp({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPosts() async {
    final decodedJson = await requestApi(
      () => client.get(
        Uri.parse('$BASE_URL/posts'),
        headers: {'Content-Type': 'application/json'},
      ),
    ) as List;
    List<PostModel> posts =
        decodedJson.map((post) => PostModel.fromJson(post)).toList();
    return posts;
  }

  @override
  Future<int> addPost(PostModel postModel) async {
    final body = postModel.toJson();
    final decodedJson = await requestApi(
      () => client.post(
        Uri.parse('$BASE_URL/posts'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      ),
    ) as Map;

    return Future.value(decodedJson['id']);
  }

  @override
  Future<Unit> deletePost(int id) async {
    final decodedJson = await requestApi(
      () => client.delete(
        Uri.parse('$BASE_URL/posts/$id'),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = postModel.toJson();
    final decodedJson = await requestApi(
      () => client.patch(
        Uri.parse('$BASE_URL/posts/${postModel.id}'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    return Future.value(unit);
  }

  Future<dynamic> requestApi(Function restRequest) async {
    try {
      final response = await restRequest();
      final decodedJson = DecodeResponse.decode(response) as dynamic;
      return decodedJson;
    } on SocketException {
      throw ExceptionSocket();
    } on FormatException {
      throw ExceptionFormat();
    } on TimeoutException {
      throw ExceptionTimeout();
    } on HandshakeException {
      throw ExceptionHandshake();
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } on Exception {
      throw ExceptionOther();
    }
  }
}
