import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';

import 'recent_talk_friend_list_tile.dart';

class FriendList extends StatelessWidget {
  VoiceFriendFormScreenViewModel vm;
  List<FriendPresentation> users;
  FriendList({Key? key, required this.vm, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(vm.userType),
        const SizedBox(height: 100, child: Text("검색창")),
        SizedBox(
          height: getProportionateScreenHeight(250),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return FriendListTile(user: users[index]);
              }),
        ),
        vm.busy
            ? SizedBox(
                height: getProportionateScreenHeight(400),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : (users.isEmpty
                ? const CenterSentence(
                    sentence: "추천 유저 없음",
                    verticalSpace: 50,
                  )
                : Container()),
      ],
    );
  }
}
