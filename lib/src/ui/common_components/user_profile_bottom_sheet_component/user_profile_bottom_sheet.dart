import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/profile_header.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/profile_interest.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';

import '../../../business_logic/models/enums/friendRequestStatus.dart';
import '../profile_bottom_sheet_component/components/friend_request_btn.dart';
import '../profile_bottom_sheet_component/components/goto_chatroom_btn.dart';
import '../profile_bottom_sheet_component/components/profile_info.dart';
import '../profile_bottom_sheet_component/components/waiting_friend_request.dart';

class UserProfileBottomSheet extends StatefulWidget {
  final String loginId;
  final bool? bottomBtn;
  final bool? isFromVoiceRoom;
  const UserProfileBottomSheet(
      {Key? key, required this.loginId, this.bottomBtn, this.isFromVoiceRoom})
      : super(key: key);

  @override
  State<UserProfileBottomSheet> createState() => _UserProfileBottomSheetState();
}

class _UserProfileBottomSheetState extends State<UserProfileBottomSheet> {
  UserProfileViewModel vm = serviceLocator<UserProfileViewModel>();

  @override
  void initState() {
    vm.loadUserProfile(widget.loginId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    bool _hasBtn = widget.bottomBtn ?? true;
    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<UserProfileViewModel>(builder: (context, vm, child) {
          return makeDismissible(
            child: DraggableScrollableSheet(
              initialChildSize: 0.70,
              maxChildSize: 0.70,
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
                                  SizedBox(
                                    height: _hasBtn
                                        ? getProportionateScreenHeight(250)
                                        : getProportionateScreenHeight(300),
                                    child: ListView(
                                      controller: scrollController,
                                      children: [
                                        ProfileInterest(
                                            profileInterests: vm.interests),
                                      ],
                                    ),
                                  ),
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
    return GoToChatRoomBtn(profileLoginId: vm.profile.loginId);
    // switch (vm.profile.friendRequestStatus) {
    //   case FriendRequestStatus.ACCEPTED:
    //     return (widget.isFromVoiceRoom == true)
    //         ? const BottomFixedBtnDecoBox(
    //             child: DisabledDefaultBtn(text: '대화 하기'))
    //         : GoToChatRoomBtn(profileLoginId: vm.profile.loginId);
    //   case FriendRequestStatus.UNACCEPTED:
    //     return const WaitingFriendRequest();
    //   default:
    //     return FriendRequestBtn(
    //       vm: vm,
    //       profileLoginId: vm.profile.loginId,
    //     );
    // }
  }
}
