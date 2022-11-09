import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/mypage_post_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/notification_alarm_in_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/additional_info_tab.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/menu_list.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/my_info_edit_btn.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/my_interest_edit_btn.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/show_info.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/my_page_tabbar.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/show_interest.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_post/mypage_post_screen.dart';

class Body extends StatelessWidget {
  MypageViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // controller: vm.myPageScrollController,
      // physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpacing(),
          //프로필 정보 보여줌
          ShowInfo(vm: vm),
          //프로필 수정 버튼
          MyInfoEditBtn(vm: vm),
          const VerticalSpacing(of: 20),
          //관심사영역
          ShowInterest(vm: vm),
          const VerticalSpacing(of: 30),

          // HorizontalDividerCustom(
          //   color: Color(0xfff0f0f6),
          //   thickness: getProportionateScreenHeight(8),
          // ),
          const VerticalSpacing(of: 15),
          //내피드, 내 댓글 버튼
          HorizontalDividerCustom(color: Color(0xfff0f0f6)),
          _myPost(context),
          HorizontalDividerCustom(color: Color(0xfff0f0f6)),
          _myComment(context),
          HorizontalDividerCustom(color: Color(0xfff0f0f6)),
        ],
      ),
    );
  }

  Widget _myPost(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, MypagePostScreen.routeName,
              arguments: MypagePostScreenArgs("Feed"));
        },
        contentPadding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        title: Text(
          '내 피드',
          style: TextStyle(color: Color(0xff111111), fontSize: resizeFont(14)),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_forward,
          size: getProportionateScreenWidth(18),
        ),
      ),
    );
  }

  Widget _myComment(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, "/mypageComment");
        },
        contentPadding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        title: Text(
          '내 댓글',
          style: TextStyle(color: Color(0xff111111), fontSize: resizeFont(14)),
        ),
        trailing: Icon(
          CupertinoIcons.chevron_forward,
          size: getProportionateScreenWidth(18),
        ),
      ),
    );
  }
}
