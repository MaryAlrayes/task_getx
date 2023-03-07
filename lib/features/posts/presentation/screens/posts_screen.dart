import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/managers/values_manager.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/loading_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../controllers/posts_controller.dart';
import '../widgets/posts_list.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});
  var controller = Get.find<PostsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionBtn(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: GetX<PostsController>(
            builder: (_) => controller.isLoading.value
                ? _buildLoadingWidget()
                : controller.failureType.value != null
                    ? _buildErrorWidget(controller.failureType.value)
                    : _buildPostsList(),
          ),
        ),
      ),
    );
    ;
  }

  PostsList _buildPostsList() => PostsList(posts: controller.postsList.value);

  LoadingWidget _buildLoadingWidget() => const LoadingWidget();

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Posts'),
    );
  }

  FloatingActionButton _buildFloatingActionBtn() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(
          RoutesName.addPostScreen,
          arguments: {
            'isEdit': false,
          },
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  Widget _buildErrorWidget(Failure? failureTypes) {
    switch (failureTypes.runtimeType) {
      case OfflineFailure:
        return NoConnectionWidget(
          onPressed: () {
            controller.fetchPosts();
          },
        );
      case NetworkErrorFailure:
        return NetworkErrorWidget(
          message: (failureTypes as NetworkErrorFailure).message,
          onPressed: () {
            controller.fetchPosts();
          },
        );
      default:
        return Container();
    }
  }
}
