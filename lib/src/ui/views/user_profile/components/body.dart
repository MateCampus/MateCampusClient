import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/components/goto_chatroom_btn.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/user_info.dart';

class Body extends StatelessWidget {
  final UserProfileDemandSurveyViewModel vm;
  final bool hasBottomBtn;
  const Body({Key? key, required this.vm, required this.hasBottomBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: NestedScrollView(
          controller: vm.userProfileScrollController,
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverPersistentHeader(delegate: UserInfo(vm: vm)),
          ],
          body: Text('피드 올 부분'),
        )),
        SafeArea(
            child: hasBottomBtn
                ? GoToChatRoomBtn(profileLoginId: 'profileLoginId')
                : SizedBox())
      ],
    );
  }
}
