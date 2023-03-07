import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/core/managers/color_manager.dart';
import 'package:task/core/managers/values_manager.dart';
import 'package:task/features/posts/domain/entities/post_entity.dart';
import 'package:task/features/posts/presentation/controllers/posts_controller.dart';

class AddPostsScreen extends StatelessWidget {
  AddPostsScreen({super.key});

  final PostsController controller = Get.find();

  final _key = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();

  final bool isEdit = Get.arguments['isEdit'];
  final PostEntity? post = Get.arguments['post'];

  @override
  Widget build(BuildContext context) {
    title.text = post != null ? post!.title : '';
    body.text = post != null ? post!.body : '';

    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitleField(),
              const SizedBox(
                height: 16,
              ),
              _buildBodyField(),
              const SizedBox(
                height: 16,
              ),
              _buildAddEditBtn()
            ],
          ),
        ),
      )),
    );
  }

  AppBar _buildAppbar() =>  AppBar(title: Text(isEdit ? 'Edit Post' : 'Add Post'));

  Widget _buildAddEditBtn() {
    return GetX<PostsController>(builder: (controller) {
      if (controller.isLoading.value) {
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      } else {
        return ElevatedButton(
          onPressed: () {
            bool isValid = _key.currentState!.validate();
            if (isValid) {
              if (!isEdit) {
                controller.addPost(title.text, body.text);
              } else {
                controller.updatePost(title.text, body.text, post!.id!);
              }
            }
          },
          child: (Text(isEdit ? 'Edit Post' : 'Add Post')),
        );
      }
    });
  }

  Container _buildBodyField() {
    return Container(
      height: 100,
      alignment: Alignment.topLeft,
      child: TextFormField(
        controller: body,
        textAlignVertical: TextAlignVertical.top,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.multiline,
        expands: true,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Body',
          alignLabelWithHint: true,
          label: const Text('Body'),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppSize.s8,
              ),
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          } else {
            return null;
          }
        },
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
        controller: title,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Title',
          label: const Text('Title'),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.primary,
              //  width: AppSize.s1_5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppSize.s8,
              ),
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          } else {
            return null;
          }
        });
  }
}
