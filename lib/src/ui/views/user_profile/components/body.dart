import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/block/block_user_msg.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report/report_form.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_info.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_info_more.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_post_list_tile.dart';

class Body extends StatelessWidget {
  final UserProfileDemandSurveyViewModel vm;
  final bool hasBottomBtn;
  final String userLoginId;
  const Body(
      {Key? key,
      required this.vm,
      required this.hasBottomBtn,
      required this.userLoginId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: vm.userProfileScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.transparent,
          backgroundColor: kMainScreenBackgroundColor,
          title: Text(
            vm.userProfile.nickname,
            style: TextStyle(
                fontFamily: 'Pretendard',
                color: kAppBarTextColor,
                fontSize: kTitleFontSize,
                fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.chevron_back),
            iconSize: kAppBarIconSizeCP,
            color: kAppBarIconColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
              color: Colors.black,
              iconSize: kAppBarIconSizeCP,
              onPressed: (userLoginId == AuthService.loginId)
                  ? null
                  : () {
                      _reportUser(context);
                    },
            )
          ],
        ),
        SliverPersistentHeader(
            pinned: false, floating: true, delegate: UserInfo(vm: vm)),
        SliverToBoxAdapter(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoMore(vm: vm),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: getProportionateScreenHeight(15)),
            //   child: HorizontalDividerCustom(
            //     color: Color(0xfff0f0f6),
            //     thickness: getProportionateScreenHeight(10),
            //   ),
            // ),
            VerticalSpacing(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Text(
                '피드',
                style: TextStyle(
                    color: Color(0xff776677),
                    fontSize: resizeFont(12),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        )),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    UserPostListTile(vm: vm, post: vm.userPosts[index]),
                childCount: vm.userPosts.length))
      ],
    );
  }

  _reportUser(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            '차단하기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            buildCustomAlertDialog(
                context: context,
                contentWidget: const BlockUserMsg(),
                btnText: '차단',
                press: () {
                  vm.blockUser(context);
                });
          },
        ),
        BottomSheetAction(
          title: Text(
            '신고하기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ReportForm(
                      targetUserLoginId: userLoginId, reportCategoryIndex: "1");
                });
          },
        ),
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(
                fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
