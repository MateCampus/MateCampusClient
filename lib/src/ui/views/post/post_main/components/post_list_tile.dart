import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';

import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/verticalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/bottom_count_info.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/show_image.dart';

class PostListTile extends StatelessWidget {
  final PostPresentation post;
  const PostListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //유저정보영역 -> 이 영역을 누르면 상대방 프로필 창으로 넘어감
              GestureDetector(
                onTap: () {},
                child: _postUser(),
              ),

              //포스트 영역 -> 누르면 포스트디테일로 넘어감
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PostDetailScreen.routeName,
                      arguments: PostDetailScreenArgs(post.id));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //카테고리
                    post.categories.isEmpty
                        ? const SizedBox()
                        : _postCategories(),
                    //바디
                    _postBody(),
                    //사진
                    post.imageUrls.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(
                                bottom: getProportionateScreenHeight(20)),
                            child: _postImg(),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const HorizontalDividerCustom(
          color: Color(0xfff0f0f6),
        ),
        //좋아요 댓글 영역
        BottomCountInfo(post: post),
        //하단 아래 구분선
        HorizontalDividerCustom(
          thickness: getProportionateScreenHeight(5),
          color: const Color(0xfff0f0f6),
        )
      ],
    );
  }

  Widget _postUser() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: getProportionateScreenHeight(18),
        backgroundImage: post.userImageUrl.startsWith('https')
            ? CachedNetworkImageProvider(post.userImageUrl) as ImageProvider
            : AssetImage(post.userImageUrl),
      ),
      title: Text(
        post.userNickname,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: Color(0xff111111),
            fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        post.collegeName + ' \u{00B7} ' + post.createdAt,
        style: TextStyle(
            fontSize: resizeFont(12),
            color: Color(0xff767676),
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _postBody() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Text(
        post.body,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: kPostBodyStyle,
      ),
    );
  }

  Widget _postCategories() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: getProportionateScreenWidth(8),
      children: [
        ...post.categories.map((category) => Chip(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(vertical: -4),
              label: Text(category),
              labelStyle: TextStyle(
                fontSize: resizeFont(12),
                color: kMainColor,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.white,
              side: BorderSide(color: Color(0xffF8E9E7), width: 1.2),
            ))
      ],
    );
  }

  Widget _postImg() {
    int restImg = post.imageUrls.length - 1;
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      SizedBox(
          width: getProportionateScreenWidth(335),
          height: getProportionateScreenHeight(204),
          child: ClipRRect(
            borderRadius: BorderRadius.circular((5)),
            child: post.imageUrls[0].startsWith('https')
                ? CachedNetworkImage(
                    imageUrl: post.imageUrls[0],
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    post.imageUrls[0],
                    fit: BoxFit.cover,
                  ),
          )),
      Positioned(
        bottom: getProportionateScreenHeight(15),
        right: getProportionateScreenWidth(15),
        child: Container(
          width: getProportionateScreenWidth(32),
          height: getProportionateScreenHeight(24),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular((2))),
          child: Center(
            child: Text(
              '+' + restImg.toString(),
              style: TextStyle(
                  fontSize: resizeFont(12),
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
    ]);
  }
}
