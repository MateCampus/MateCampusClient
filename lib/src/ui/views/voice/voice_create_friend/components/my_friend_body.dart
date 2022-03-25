import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/friend_list.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/search_bar.dart';

class MyFriendBody extends StatelessWidget {
  VoiceFriendFormScreenViewModel vm;
  Color color;
  MyFriendBody({Key? key, required this.vm, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5), //이부분 간격 체크,
      child: Column(
        children: [
          const SearchBar(),
          Expanded(
              child: SingleChildScrollView(
                  child: FriendList(vm: vm, users: vm.friendUsers))),
          Padding(
            padding: EdgeInsets.fromLTRB(0, getProportionateScreenHeight(10), 0,
                getProportionateScreenHeight(25)),
            child: DefaultBtn(
              text: '시작하기!',
              press: () {},
              btnColor: color,
            ),
          ),
        ],
      ),
    );
  }
}
