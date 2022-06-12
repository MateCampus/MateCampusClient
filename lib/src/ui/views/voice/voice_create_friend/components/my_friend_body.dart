import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/friend_list_tile.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/my_friend_search_bar.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/voice_detail_screen.dart';

class MyFriendBody extends StatelessWidget {
  final dynamic vm;
  final List<dynamic> users;
  final Color color;
  final String isFrom;
  const MyFriendBody(
      {Key? key,
      required this.vm,
      required this.users,
      required this.color,
      required this.isFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyFriendSearchBar(vm: vm),
        //Expanded 때문에 ios에서 리스트 아래로 다 땡겼을때 여백이 남음(chat detail이랑 같은 이슈)
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return FriendListTile(vm: vm, user: users[index]);
                })),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: DefaultBtn(
              //누르면 보이스룸이 생성되면서 입장도 해야함. Navigate to voice_detail
              text: isFrom == "create" ? '시작하기!' : "초대하기",
              press: () async {
                if (isFrom == "create") {
                  VoiceRoom voiceRoom = await vm.createVoiceRoom();
                  Navigator.pushNamedAndRemoveUntil(context,
                      VoiceDetailScreen.routeName, ModalRoute.withName('/'),
                      arguments: VoiceDetailScreenArgs(voiceRoom: voiceRoom));
                } else {
                  await vm.inviteUsers(context);
                }
              },
              btnColor: color,
            ),
          ),
        ),
      ],
    );
  }
}
