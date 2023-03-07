import 'package:task/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({int? id, required String title, required String body})
      : super(id: id, title: title, body: body);

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
