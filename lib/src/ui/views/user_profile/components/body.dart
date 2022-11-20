import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/goto_chatroom_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/post_list_tile.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_info.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_info_has_interests.dart';
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
    return RefreshIndicator(
      key: vm.userProfileMainKey,
      edgeOffset: getProportionateScreenHeight(350),
      displacement: 10,
      onRefresh: () => vm.refreshUserProfileAndPost(userLoginId),
      child: CustomScrollView(
        controller: vm.userProfileScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
              pinned: false,
              delegate: vm.userInterests.isEmpty
                  ? UserInfo(vm: vm)
                  : UserInfoHasInterests(vm: vm)),
          vm.busy
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => const IsLoading(),
                      childCount: 1))
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          UserPostListTile(post: vm.userPosts[index]),
                      childCount: vm.userPosts.length))
        ],
      ),
    );
  }

// @override
//    build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//             child: NestedScrollView(
//           controller: vm.userProfileScrollController,
//           headerSliverBuilder: (context, innerBoxScrolled) => [
//             SliverPersistentHeader(
//                 delegate: vm.userInterests.isEmpty
//                     ? UserInfo(vm: vm)
//                     : UserInfoHasInterests(vm: vm)),
//           ],
//           body: Column(
//             children: [
//               HorizontalDividerCustom(
//                 thickness: getProportionateScreenHeight(8),
//                 color: const Color(0xfff0f0f6),
//               ),
//               RefreshIndicator(
//                   key: vm.userProfileMainKey,
//                   displacement: 0,
//                   onRefresh: () => vm.refreshUserProfileAndPost(userLoginId),
//                   child: ListView.builder(
//                       itemCount: vm.userPosts.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return PostListTile(post: vm.userPosts[index]);
//                       })),
//             ],
//           ),
//         )),
//         SafeArea(
//             child: hasBottomBtn
//                 ? GoToChatRoomBtn(profileLoginId: vm.userProfile.loginId)
//                 : SizedBox())
//       ],
//     );
//   }

}
