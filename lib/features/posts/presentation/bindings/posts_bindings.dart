import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task/core/network/check_internet.dart';
import 'package:task/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:task/features/posts/data/repositories/post_repo_imp.dart';
import 'package:task/features/posts/domain/usecases/add_post.dart';
import 'package:task/features/posts/domain/usecases/delete_post.dart';
import 'package:task/features/posts/domain/usecases/get_all_posts.dart';
import 'package:task/features/posts/domain/usecases/update_post.dart';
import 'package:task/features/posts/presentation/controllers/posts_controller.dart';

class PostsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InternetConnectionChecker());
    Get.lazyPut(() => Client());
    Get.lazyPut(() => NetworkInfoImpl(
        internetConnectionChecker: Get.find<InternetConnectionChecker>()));
    Get.lazyPut(() => PostsRemoteWithHttp(client: Get.find()));
    Get.lazyPut(() => PostRepoImp(
        postsRemoteDataSource: Get.find<PostsRemoteWithHttp>(),
        networkInfo: Get.find<NetworkInfoImpl>()));
    Get.lazyPut(() => UpdatePostUseCase(postRepo: Get.find<PostRepoImp>()));
    Get.lazyPut(() => DeletePostUseCase(postRepo: Get.find<PostRepoImp>()));
    Get.lazyPut(() => AddPostUseCase(postRepo: Get.find<PostRepoImp>()));
    Get.lazyPut(() => GetAllPostsUseCase(postRepo: Get.find<PostRepoImp>()));
    Get.lazyPut(() => PostsController(
          deletePostUseCase: Get.find<DeletePostUseCase>(),
          updatePostUseCase: Get.find<UpdatePostUseCase>(),
          getAllPostsUseCase: Get.find<GetAllPostsUseCase>(),
          addPostUseCase: Get.find<AddPostUseCase>(),
        ));
  }
}
