import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/managers/font_manager.dart';
import 'package:task/core/managers/styles_manager.dart';
import 'package:task/core/managers/values_manager.dart';
import 'package:task/core/routes/routes_name.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/presentation/controllers/posts_controller.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key, required});

  final PostsController controller = Get.find();
  final PostEntity post = Get.arguments['post'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      persistentFooterButtons: _buildPresistentFooterBtn,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: _buildContent()),
      ),
    );
  }

  List<Widget> get _buildPresistentFooterBtn {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildEditBtn(),
          const SizedBox(
            width: 4,
          ),
          _buildDeleteBtn()
        ],
      )
    ];
  }

  Column _buildContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text('${post.id}'),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: getBoldStyle(
                      color: Colors.black,
                      fontSize: FontSize.s18,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(post.body),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Expanded _buildEditBtn() {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          Get.toNamed(
           RoutesName.addPostScreen,
            arguments: {'isEdit': true, 'post': post},
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        icon: const Icon(Icons.edit),
        label: const Text(
          'edit',
        ),
      ),
    );
  }

  Expanded _buildDeleteBtn() {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          controller.deletePost(post.id!);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        icon: const Icon(Icons.delete),
        label: const Text(
          'delete',
        ),
      ),
    );
  }
}
