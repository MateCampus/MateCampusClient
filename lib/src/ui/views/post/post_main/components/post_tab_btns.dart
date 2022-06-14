import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class PostTabBtns extends SliverPersistentHeaderDelegate {
  PostMainScreenViewModel vm;
  PostTabBtns({required this.vm});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      //배경색 넣기위해 컨테이너 사용

      height: getProportionateScreenHeight(60), //maxExtend, minExtend와 동일하게 해둠
      decoration: const BoxDecoration(color: screenBackgroundColor),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                vm.loadPostsByType(0);
              },
              child: Text(
                '인기',
                style: TextStyle(
                    color: vm.sortType == "popular" ? Colors.white : postColor),
              ),
              style: TextButton.styleFrom(
                  minimumSize: Size(getProportionateScreenWidth(48),
                      getProportionateScreenHeight(36)),
                  backgroundColor:
                      vm.sortType == "popular" ? mainColor : Colors.white,
                  side: vm.sortType == "popular" //테두리 색
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const HorizontalSpacing(of: 5),
            TextButton(
              onPressed: () {
                vm.loadPostsByType(1);
              },
              child: Text(
                '추천',
                style: TextStyle(
                    color:
                        vm.sortType == "recommend" ? Colors.white : postColor),
              ),
              style: TextButton.styleFrom(
                  minimumSize: Size(getProportionateScreenWidth(48),
                      getProportionateScreenHeight(36)),
                  backgroundColor:
                      vm.sortType == "recommend" ? mainColor : Colors.white,
                  side: vm.sortType == "recommend"
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const HorizontalSpacing(of: 5),
            TextButton(
              onPressed: () {
                vm.loadPostsByType(2);
              },
              child: Text(
                '최신',
                style: TextStyle(
                    color: vm.sortType == "recent" ? Colors.white : postColor),
              ),
              style: TextButton.styleFrom(
                  minimumSize: Size(getProportionateScreenWidth(48),
                      getProportionateScreenHeight(36)),
                  backgroundColor:
                      vm.sortType == "recent" ? mainColor : Colors.white,
                  side: vm.sortType == "recent"
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const Spacer(),
            TextButton.icon(
                icon: Icon(
                  CupertinoIcons.checkmark_alt,
                  size: getProportionateScreenWidth(15),
                ),
                label: Text('우리학교 글만 보기'),
                onPressed: () {
                  vm.setCollegeFilter();
                },
                style: TextButton.styleFrom(
                  primary: vm.collegeFilter ? mainColor : postColor,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => getProportionateScreenHeight(60);

  @override
  double get minExtent => getProportionateScreenHeight(60);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
