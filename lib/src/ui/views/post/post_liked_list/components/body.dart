import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_liked_list_viewmodel.dart';

class Body extends StatelessWidget {
  final PostLikedListViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('좋아요 성공ㅁ런ㄷ리먼랴ㅣㅁㄴ'),
    );
  }
}
