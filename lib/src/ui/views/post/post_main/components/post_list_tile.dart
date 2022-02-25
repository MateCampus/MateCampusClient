import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';

class PostListTile extends StatelessWidget {
  PostPresentation post;
  PostListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(post.body),
          Text(post.createdAt),
          Text(post.likedCount),
          Text(post.userNickname),
          const Text("여기까지가 post 1번")
        ],
      ),
    );
  }
}
