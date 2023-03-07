import 'package:dartz/dartz.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/features/posts/domain/repositories/post_repo.dart';

class DeletePostUseCase {
  final PostRepo postRepo;
  DeletePostUseCase({
    required this.postRepo,
  });
  Future<Either<Failure, Unit>> call(int id) async {
    print('hi use case');
    return await postRepo.deletePost(id);
  }
}
