// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/domain/repositories/post_repo.dart';

class GetAllPostsUseCase {
  final PostRepo postRepo;
  GetAllPostsUseCase({
    required this.postRepo,
  });
  Future<Either<Failure, List<PostEntity>>> call() async {
    return await postRepo.getAllPosts();
  }
}
