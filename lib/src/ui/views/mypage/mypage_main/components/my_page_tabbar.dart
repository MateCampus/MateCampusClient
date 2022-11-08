import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/circle_image_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class MyPageTabbar extends SliverPersistentHeaderDelegate {
  MypageViewModel vm;
  MyPageTabbar({required this.vm});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(getProportionateScreenHeight(40)),
                    child: TabBar(
                        indicatorColor: kMainColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                          fontSize: kTabbarTextFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: const Color(0xff7f7f7f),
                        unselectedLabelStyle: TextStyle(
                          fontSize: kTabbarTextFontSize,
                        ),
                        tabs: [
                          SizedBox(
                              height: getProportionateScreenHeight(30),
                              child: const Tab(text: '친구 목록')),
                          SizedBox(
                              height: getProportionateScreenHeight(30),
                              child: const Tab(text: '친구 신청'))
                        ]),
                  ),
                ),

                backgroundColor: kSubScreenBackgroundColor, //배경색
                body: TabBarView(children: [
                 Text('1'), Text('2')
                ]),
              ));
  }



 

  @override
  double get maxExtent => getProportionateScreenHeight(40);

  @override
  double get minExtent => getProportionateScreenHeight(40);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
