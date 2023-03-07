import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/managers/theme_manager.dart';
import 'package:task/core/routes/get_pages.dart';
import 'package:task/core/routes/routes_name.dart';
import 'package:task/features/posts/presentation/bindings/posts_bindings.dart';
import 'package:task/features/posts/presentation/screens/add_edit_post_screen.dart';
import 'package:task/features/posts/presentation/screens/posts_details.dart';
import 'package:task/features/posts/presentation/screens/posts_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemeData(),
      initialRoute: RoutesName.postsScreen,
      getPages:appPages,
    );
  }

}
