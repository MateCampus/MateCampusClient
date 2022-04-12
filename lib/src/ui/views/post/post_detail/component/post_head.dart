import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class PostHead extends StatelessWidget {
  PostDetailPresentation post;
  PostHead({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //카테고리 나열 -> viewmodel에서 맵핑할때 이렇게까지 작업하고 여기에서는 Text(post.category) 이런식으로만 쓸 수 있게 해야할거같음.
          children: [
            ...post.categories.map((category) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xfff8f8f8)),
                  child: Text(
                    category + "  ",
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
          ],
        ),
        const VerticalSpacing(of: 10),
        Text(
          post.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        //const VerticalSpacing(of: 10),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          minVerticalPadding: getProportionateScreenHeight(15),
          horizontalTitleGap: getProportionateScreenWidth(10),
          dense: true,
          leading: CircleAvatar(
            radius: 18,

            backgroundImage:
                AssetImage(post.userImageUrl), //이미지만 넣으면 에러남(아마도 해결)
          ),
          title: Text(
            post.userNickname,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            post.createdAt,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
