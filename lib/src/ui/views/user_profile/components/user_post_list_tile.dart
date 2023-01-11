import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/bottom_count_info.dart';

class UserPostListTile extends StatelessWidget {
  final UserProfileDemandSurveyViewModel vm;
  final PostPresentation post;
  final Function refresh;
  const UserPostListTile(
      {Key? key, required this.vm, required this.post, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacing(of: getProportionateScreenHeight(15)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PostDetailScreen.routeName,
                          arguments: PostDetailScreenArgs(post.id))
                      .then((value) {
                    refresh();
                  });
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
                                bottom: getProportionateScreenHeight(10)),
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
        //좋아요 댓글 영역 -> 이것만 일단 포스트메인에서 쓰는거 끌어다쓴다.(뷰모델만 바꿔서 보냄.)
        BottomCountInfo(vm: vm, post: post),
        //하단 아래 구분선
        HorizontalDividerCustom(
          thickness: getProportionateScreenHeight(5),
          color: const Color(0xfff0f0f6),
        )
      ],
    );
  }

  Widget _postBody() {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
      child: Text(
        post.body,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: kPostBodyStyle,
      ),
    );
  }

  Widget _postCategories() {
    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
      child: Wrap(
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
      ),
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
