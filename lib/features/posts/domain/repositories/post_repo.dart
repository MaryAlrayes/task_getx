import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';



abstract class PostRepo {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, int>> addPost(PostEntity post);
}
