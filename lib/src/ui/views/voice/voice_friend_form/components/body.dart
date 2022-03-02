import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_friend_form/components/recent_talk_friend_list.dart';

class Body extends StatelessWidget {
  VoiceFriendFormScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    vm.changeUserType(0);
                  },
                  child: Text("최근대화")),
              TextButton(
                  onPressed: () {
                    vm.changeUserType(1);
                  },
                  child: Text("내친구")),
            ],
          ),
          FriendList(
              vm: vm,
              users: vm.userType == "recentTalk"
                  ? vm.recentTalkUsers
                  : vm.friendUsers),
        ],
      ),
    );
  }
}
