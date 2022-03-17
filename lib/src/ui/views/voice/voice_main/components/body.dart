import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list_tile.dart';

class Body extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: RecommendUser(vm: vm),
          pinned: false,
          floating: true,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    VoiceRoomListTile(voiceRoom: vm.voiceRooms[index]),
                childCount: vm.voiceRooms.length))
      ],
    );
  }
}


/*원래코드
class Body extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          Column(children: [RecommendUserList(vm: vm), VoiceRoomList(vm: vm)]),
    );
  }
}
*/