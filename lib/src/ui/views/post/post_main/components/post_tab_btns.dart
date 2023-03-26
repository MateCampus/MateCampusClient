import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class PostTabBtns extends SliverPersistentHeaderDelegate {
  PostMainScreenViewModel vm;
  PostTabBtns({required this.vm});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      //배경색 넣기위해 컨테이너 사용

      height: getProportionateScreenHeight(40), //maxExtend, minExtend와 동일하게 해둠
      decoration: const BoxDecoration(color: kMainScreenBackgroundColor),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Row(
          children: [
            const Spacer(),
            TextButton.icon(
                icon: Icon(
                  CupertinoIcons.checkmark_alt,
                  size: getProportionateScreenWidth(15),
                ),
                label: const Text('우리 학교 글만 보기'),
                onPressed: () {
                  vm.setCollegeFilter();
                },
                style: TextButton.styleFrom(
                  primary: vm.collegeFilter ? kMainColor : kPostBtnColor,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => getProportionateScreenHeight(40);

  @override
  double get minExtent => getProportionateScreenHeight(40);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
