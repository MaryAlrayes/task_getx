import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/domain/repositories/post_repo.dart';

class AddPostUseCase {
  final PostRepo postRepo;
  AddPostUseCase({
    required this.postRepo,
  });
  Future<Either<Failure, int>> call(String title,String body) async {
    PostEntity post = PostEntity(title:title , body: body);
    return await postRepo.addPost(post);
  }
}
