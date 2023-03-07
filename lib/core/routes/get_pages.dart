import 'package:get/get.dart';
import 'package:task/core/routes/routes_name.dart';
import 'package:task/features/posts/presentation/bindings/posts_bindings.dart';
import 'package:task/features/posts/presentation/screens/add_edit_post_screen.dart';
import 'package:task/features/posts/presentation/screens/posts_details.dart';
import 'package:task/features/posts/presentation/screens/posts_screen.dart';

var appPages = [
  GetPage(
    name: RoutesName.postsScreen,
    page: () => PostsScreen(),
    binding: PostsBindings(),
  ),
  GetPage(
    name: RoutesName.addPostScreen,
    page: () => AddPostsScreen(),
  ),
  GetPage(
    name: RoutesName.postDetails,
    page: () => PostDetails(),
  ),
];
