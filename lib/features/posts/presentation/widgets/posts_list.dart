import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/managers/font_manager.dart';
import 'package:task/core/managers/styles_manager.dart';
import 'package:task/core/routes/routes_name.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';

class PostsList extends StatelessWidget {
  final List<PostEntity> posts;
  const PostsList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          key: UniqueKey(),
          onTap: () => Get.toNamed(RoutesName.postDetails,
              arguments: {'post': posts[index]}),
          leading: CircleAvatar(
            child: Text(
              '${posts[index].id}',
            ),
          ),
          title: Text(
            posts[index].title,
            style: getRegularStyle(
              color: Colors.black,
              fontSize: FontSize.s18,
            ),
          ),
          subtitle: Text(
            posts[index].body,
          ),
        ),
      )),
    );
  }
}
