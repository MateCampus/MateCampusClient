import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:truncate/truncate.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class PostListTile extends StatelessWidget {
  PostPresentation post;
  PostListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 2.0,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 5), //이부분 간격 체크
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#" + post.category,
              style: const TextStyle(fontSize: 12),
            ),
            VerticalSpacing(of: 10),
            Text(
              post.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            VerticalSpacing(of: 5),
            Text(
              truncate(post.body, 68,
                  omission: "...", position: TruncatePosition.end),
              style: const TextStyle(fontSize: 13, color: Color(0xff818181)),
            ),
            VerticalSpacing(of: 10),
            Row(
              children: [
                Text(
                  "좋아요 " + post.likedCount,
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
                HorizontalSpacing(of: 10),
                Text(
                  "조회수 " + post.viewCount,
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
                HorizontalSpacing(of: 10),
                Text(
                  "댓글 " + post.commentCount,
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   height: getProportionateScreenHeight(144),
    //   width: getProportionateScreenWidth(335),
    //   //padding: const EdgeInsets.all(10),
    //   color: Colors.white,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     //mainAxisAlignment: MainAxisAlignment.start,
    // children: [
    //   Text(
    //     "#" + post.category,
    //     style: const TextStyle(fontSize: 12),
    //   ),
    //   Text(
    //     post.title,
    //     style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    //   ),
    //   Text(
    //     truncate(post.body, 50,
    //         omission: "...", position: TruncatePosition.end),
    //     style: const TextStyle(fontSize: 13, color: Color(0xff818181)),
    //   ),
    //   Row(
    //     children: [
    //       Text("좋아요 " + post.likedCount),
    //       Text("조회수 " + post.viewCount),
    //       Text("댓글 " + post.commentCount),
    //     ],
    //   ),
    //   Text(post.createdAt),
    //   Text(post.likedCount),
    //   Text(post.userNickname),
    //   const Text("여기까지가 post 끝")
    // ],
    //   ),
    // );
  }
}
