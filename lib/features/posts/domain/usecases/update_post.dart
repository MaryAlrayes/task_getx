import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/domain/repositories/post_repo.dart';

class UpdatePostUseCase {
  final PostRepo postRepo;
  UpdatePostUseCase({
    required this.postRepo,
  });
  Future<Either<Failure, Unit>> call(int id,String title,String body) async {
     PostEntity post = PostEntity(title:title , body: body,id:id );
    return await postRepo.updatePost(post);
  }
}
