import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_post_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/post_list_tile.dart';

class Body extends StatelessWidget {
  final MypagePostViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: vm.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostListTile(post: vm.posts[index]);
        });
  }
}
