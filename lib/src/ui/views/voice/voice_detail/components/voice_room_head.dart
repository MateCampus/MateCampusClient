import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class VoiceRoomHead extends StatelessWidget {
  final VoiceRoomPresentation voiceRoom;
  const VoiceRoomHead({Key? key, required this.voiceRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: getProportionateScreenWidth(8),
            children: [
              ...voiceRoom.categories.map((category) => Chip(
                    label: Text(category),
                    labelStyle: const TextStyle(fontSize: 12),
                    backgroundColor: Colors.white,
                  ))
            ],
          ),
          const VerticalSpacing(of: 5),
          voiceRoom.type == VoiceRoomType.PUBLIC
              ? Text(
                  voiceRoom.title,
                  style: TextStyle(
                      fontSize: kTitleFontSize, fontWeight: FontWeight.bold),
                )
              : Text(
                  '\u{1F512} ' + voiceRoom.title,
                  style: TextStyle(
                      fontSize: kTitleFontSize, fontWeight: FontWeight.bold),
                )
        ],
      ),
    );
  }
}
