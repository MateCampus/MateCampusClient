import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'voice_room_list_tile.dart';

class VoiceRoomList extends StatelessWidget {
  VoiceMainScreenViewModel vm;
  VoiceRoomList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(20),
                getProportionateScreenWidth(20),
                getProportionateScreenHeight(10)),
            child: const Text(
              'NOW \u{1F34A}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            )),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vm.voiceRooms.length,
            itemBuilder: (BuildContext context, int index) {
              return VoiceRoomListTile(voiceRoom: vm.voiceRooms[index]);
            }),
      ],
    );
  }
}
