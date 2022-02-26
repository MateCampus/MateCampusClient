import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';

class VoiceRoomListTile extends StatelessWidget {
  VoiceRoomPresentation voiceRoom;
  VoiceRoomListTile({Key? key, required this.voiceRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(voiceRoom.title),
          ...voiceRoom.categories.map((category) => Text(category)),
          Text(voiceRoom.createdAt),
          ...voiceRoom.memberImageUrls.map(
            (imageUrl) => Image.asset(imageUrl),
          ),
          const Text("----- 여기까지"),
        ],
      ),
    );
  }
}
