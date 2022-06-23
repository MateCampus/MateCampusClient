import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/friend_request_btn.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/goto_chatroom_btn.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/profile_header.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/profile_info.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/profile_interest.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/waiting_friend_request.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';

import '../../../business_logic/models/enums/friendRequestStatus.dart';
import '../../../business_logic/models/enums/interestStatus.dart';
import 'components/interest_different_chip.dart';
import 'components/interest_none_chip.dart';
import 'components/interest_same_chip.dart';

/// Friend Profile bottom sheet로 이름 변경 예정
class ProfileBottomSheet extends StatefulWidget {
  final int friendId;
  final bool? bottomBtn;
  const ProfileBottomSheet({Key? key, required this.friendId, this.bottomBtn})
      : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  ProfileViewModel vm = serviceLocator<ProfileViewModel>();

  @override
  void initState() {
    vm.loadProfile(widget.friendId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    bool _hasBtn = widget.bottomBtn ?? true;
    return ChangeNotifierProvider<ProfileViewModel>(
        create: (context) => vm,
        child: Consumer<ProfileViewModel>(builder: (context, vm, child) {
          return makeDismissible(
            child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.7,
              builder: (BuildContext context,
                      ScrollController scrollController) =>
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      child: vm.busy
                          ? const IsLoading()
                          : SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: scrollController,
                              child: Column(
                                children: [
                                  ProfileHeader(vm: vm),
                                  ProfileInfo(
                                    imageUrl: vm.profile.imageUrl,
                                    nickname: vm.profile.nickname,
                                    majorName: vm.profile.majorName,
                                    collegeName: vm.profile.collegeName,
                                    introduction: vm.profile.introduction,
                                  ),
                                  Column(children: [
                                    // GridView.builder(
                                    //     itemCount: vm.interests.length,
                                    //     gridDelegate:
                                    //         SliverGridDelegateWithMaxCrossAxisExtent(
                                    //       maxCrossAxisExtent: 125,
                                    //       mainAxisSpacing: 0,
                                    //     ),
                                    //     itemBuilder: (BuildContext context,
                                    //         int index) {
                                    //       //item 의 반목문 항목 형성
                                    //       return _buildInterestChip(
                                    //           vm.interests[index]);
                                    //     }),
                                    SizedBox(
                                      height: _hasBtn
                                          ? getProportionateScreenHeight(250)
                                          : getProportionateScreenHeight(300),
                                      child: ListView(
                                        // controller: scrollController,
                                        children: [
                                          ProfileInterest(
                                              profileInterests: vm.interests),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  _hasBtn
                                      ? SafeArea(child: _bottomFixedBtn())
                                      : const SizedBox()
                                ],
                              ),
                            )),
            ),
          );
        }));
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget _bottomFixedBtn() {
    switch (vm.profile.friendRequestStatus) {
      case FriendRequestStatus.ACCEPTED:
        return GoToChatRoomBtn(profileLoginId: vm.profile.loginId);
      case FriendRequestStatus.UNACCEPTED:
        return const WaitingFriendRequest();
      default:
        return FriendRequestBtn(
          vm: vm,
          profileLoginId: vm.profile.loginId,
        );
    }
  }

  Widget _buildInterestChip(InterestPresentation interestPresentation) {
    switch (interestPresentation.status) {
      case InterestStatus.SAME:
        return InterestSameChip(interest: interestPresentation);

      case InterestStatus.DIFFERENT:
        return InterestDifferentChip(interest: interestPresentation);
      default: //status.none 상태
        return InterestNoneChip(interest: interestPresentation);
    }
  }
}
