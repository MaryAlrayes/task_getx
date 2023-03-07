import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/utils/helpers/snackbar.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/add_post.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_posts.dart';
import '../../domain/usecases/update_post.dart';

class PostsController extends GetxController {
  final GetAllPostsUseCase getAllPostsUseCase;
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  PostsController({
    required this.deletePostUseCase,
    required this.updatePostUseCase,
    required this.getAllPostsUseCase,
    required this.addPostUseCase,
  });

  var isLoading = false.obs;
  Rxn<Failure> failureType = Rxn<Failure>();
  var postsList = <PostEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    isLoading.value = true;
    var res = await getAllPostsUseCase();
    res.fold(
      (failure) {
        failureType.value = (failure);
      },
      (posts) {
        postsList.assignAll(posts);
        failureType.value = (null);
      },
    );
    isLoading.value = false;
  }

  void addPost(String title, String body) async {
    isLoading.value = true;

    final res = await addPostUseCase(title, body);
    res.fold(
      (failure) => _mapFailureToMessage(failure),
      (id) {
        postsList.value.insert(0, PostEntity(title: title, body: body, id: id));
        showSnackbar(
            Get.context!, 'Post has been added successfully', Colors.green);
        postsList.refresh();
        Get.back();
      },
    );
    isLoading.value = false;
  }

  void updatePost(String title, String body, int id) async {
    Get.defaultDialog(
      title: 'Editing...',
      content: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final res = await updatePostUseCase(id, title, body);
    res.fold(
      (failure) {
        Get.back();
        _mapFailureToMessage(failure);
      },
      (_) {
        int index = postsList.value.indexWhere((element) => element.id == id);
        postsList[index] = PostEntity(id: id, title: title, body: body);
        showSnackbar(
            Get.context!, 'Post has been updated successfully', Colors.green);
        postsList.refresh();
        Get.until((route) => Get.currentRoute == RoutesName.postsScreen);
      },
    );
  }

  void deletePost(int id) async {
    Get.defaultDialog(
      title: 'Deleting...',
      content: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final res = await deletePostUseCase(id);
    res.fold(
      (failure) {
        Get.back();
        _mapFailureToMessage(failure);
      },
      (_) {
        postsList.removeWhere((element) => element.id == id);
        showSnackbar(
            Get.context!, 'Post has been deleted successfully', Colors.green);
        postsList.refresh();
        Get.until((route) => Get.currentRoute == RoutesName.postsScreen);
      },
    );
  }

  void _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        Get.snackbar('No internet connection!',
            'Please, check your internet connection and try again later',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            margin: const EdgeInsets.all(8));
        break;

      case NetworkErrorFailure:
        Get.snackbar('Something went wrong, try again',
            (failure as NetworkErrorFailure).message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.grey,
            margin: const EdgeInsets.all(8));
        break;

      default:
        break;
    }
  }
}
