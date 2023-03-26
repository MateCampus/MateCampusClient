import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_liked_list_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/views/post/post_liked_list/components/liked_user_list_tile.dart';

class Body extends StatelessWidget {
  final PostLikedListViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: vm.likedUsers.isEmpty
            ? const CenterSentence(sentence: '', bottomSpace: 150)
            : ListView.builder(
                shrinkWrap: true,
                itemCount: vm.likedUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return LikedUserListTile(
                      vm: vm, likeduser: vm.likedUsers[index]);
                }));
  }
}
