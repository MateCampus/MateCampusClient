import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/recommend_user_list.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_main/components/voice_room_list.dart';

class Body extends StatelessWidget {
  VoiceMainScreenViewModel model;
  Body({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        RecommendUserList(model: model),
        VoiceRoomList(model: model)
      ]),
    );
  }
}
