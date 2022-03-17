import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';

import 'voice_room_list_tile.dart';

class VoiceRoomList extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  VoiceRoomList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vm.voiceRooms.length,
            itemBuilder: (BuildContext context, int index) {
              return VoiceRoomListTile(voiceRoom: vm.voiceRooms[index]);
            }),
        vm.busy
            ? SizedBox(
                height: getProportionateScreenHeight(400),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
            : (vm.voiceRooms.isEmpty
                ? const CenterSentence(
                    sentence: "등록된 게시글이 없습니다.",
                    verticalSpace: 50,
                  )
                : Container()),
      ],
    );
  }
}
