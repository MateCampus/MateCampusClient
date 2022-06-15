import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';

import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/bottom_count_info.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/show_image.dart';

class PostListTile extends StatelessWidget {
  final PostPresentation post;
  const PostListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PostDetailScreen.routeName,
            arguments: PostDetailScreenArgs(post.id, post.likedCount));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(5),
            horizontal: getProportionateScreenWidth(12)),
        child: Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey.shade100,
          elevation: 4.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post.imageUrls.isEmpty
                  ? const SizedBox()
                  : ShowImage(images: post.imageUrls),
              post.categories.isEmpty ? _onlyBody() : _hasCategoryWithBody(),
              const HorizontalDividerCustom(),
              BottomCountInfo(post: post)
            ],
          ),
        ),
      ),
    );
  }

//카테고리 넣은 후 테스트 해봐야함
  Widget _hasCategoryWithBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(5)),
          child: Row(
            //카테고리 나열 -> viewmodel에서 Row로 정렬되게끔 바꾸기
            children: [
              ...post.categories.map((category) => Text(
                    category + "  ",
                    style: const TextStyle(fontSize: 12),
                  ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(5),
              horizontal: getProportionateScreenWidth(15)),
          child: Text(
            post.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: kPostBodyStyle,
          ),
        )
      ],
    );
  }

  Widget _onlyBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(15),
          horizontal: getProportionateScreenWidth(15)),
      child: Text(
        post.body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: kPostBodyStyle,
      ),
    );
  }
}
