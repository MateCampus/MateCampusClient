import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/change_voice_button_temp.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/voice_chat.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/voice_room_head.dart';

class Body extends StatelessWidget {
  final VoiceDetailViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VoiceRoomHead(voiceRoom: vm.voiceRoom),
        VoiceChat(vm: vm),
        ChangeVoiceBtn(vm: vm)
      ],
    );
  }
}
