import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_post_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/post_list_tile.dart';

class Body extends StatelessWidget {
  final MypagePostViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: vm.myPostMainKey,
      edgeOffset: getProportionateScreenHeight(110),
      displacement: 10,
      onRefresh: () => vm.refreshMyPost(),
      child: ListView.builder(
          controller: vm.myPostScrollController,
          itemCount: vm.myPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostListTile(
                post: vm.myPosts[index],
                refresh: () => vm.myPostMainKey.currentState?.show());
          }),
    );
  }
}
