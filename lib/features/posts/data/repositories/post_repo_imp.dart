import 'package:dartz/dartz.dart';
import 'package:task/core/errors/exceptions.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/network/check_internet.dart';
import 'package:task/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:task/features/posts/data/models/post_model.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/domain/repositories/post_repo.dart';

class PostRepoImp extends PostRepo {
  PostsRemoteDataSource postsRemoteDataSource;
  final NetworkInfo networkInfo;

  PostRepoImp({
    required this.postsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final res = await _getData(
      () => postsRemoteDataSource.getAllPosts(),
    );
    return res.fold((failure) => Left(failure), (posts) => Right(posts));
  }

  @override
  Future<Either<Failure, int>> addPost(PostEntity post) async {
    PostModel postModel = PostModel(title: post.title, body: post.body);
    final res = await _getData(
      () => postsRemoteDataSource.addPost(postModel),
    );
    return res.fold((failure) => Left(failure), (id) => Right(id as int));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
   
    final res = await _getData(
      () => postsRemoteDataSource.deletePost(id),
    );
    return res.fold((failure) => Left(failure), (r) => const Right(unit));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    final res = await _getData(
      () => postsRemoteDataSource.updatePost(postModel),
    );
    return res.fold((failure) => Left(failure), (r) => const Right(unit));
  }


  Future<Either<Failure, dynamic>> _getData(
      Function deleteOrUpdateOrAdd) async {

    if (await networkInfo.isConnected) {
      try {

        return Right(await deleteOrUpdateOrAdd());
      } on ExceptionTimeout {
        return Left(NetworkErrorFailure(message: 'Time out'));
      } on ExceptionSocket {
        return Left(NetworkErrorFailure(message: 'Socket Error'));
      } on ExceptionFormat {
        return Left(NetworkErrorFailure(message: 'Bad Response Format'));
      } on ExceptionHandshake {
        return Left(NetworkErrorFailure(message: 'Handshake Error'));
      } on ExceptionOther {
        return Left(NetworkErrorFailure(message: 'Error'));
      } on CustomException catch (e) {
        return Left(NetworkErrorFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
