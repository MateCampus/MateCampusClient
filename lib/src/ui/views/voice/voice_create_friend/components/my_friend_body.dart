import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/friend_list_tile.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/search_bar.dart';

class MyFriendBody extends StatelessWidget {
  final VoiceCreateViewModel vm;
  final List<UserPresentation> users;
  final Color color;
  const MyFriendBody(
      {Key? key, required this.vm, required this.users, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(vm: vm),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return FriendListTile(vm: vm, user: users[index]);
                })),
        DefaultShadowBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10),
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(25)),
            child: DefaultBtn(
              text: '시작하기!',
              press: () {
                vm.createVoiceRoom();
              },
              btnColor: color,
            ),
          ),
        ),
      ],
    );
  }
}
