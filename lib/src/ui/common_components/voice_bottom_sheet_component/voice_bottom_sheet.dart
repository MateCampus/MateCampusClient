import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/voice_bottom_sheet_component/component/create_private_voice_room_btn.dart';
import 'package:zamongcampus/src/ui/common_components/voice_bottom_sheet_component/component/create_public_voice_room_btn.dart';

class VoiceBottomSheet extends StatelessWidget {
  const VoiceBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Container(
      height: getProportionateScreenHeight(235),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: getProportionateScreenHeight(8)),
            height: getProportionateScreenHeight(4),
            width: getProportionateScreenWidth(36),
            decoration: const BoxDecoration(
                color: Color(0xffe2e2e2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(20)),
            child: const Text(
              '어떤 대화방을 만드시겠어요?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          //const VerticalSpacing(of: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CreatePublicVoiceRoomBtn(),
              CreatePrivateVoiceRoomBtn()
            ],
          )
        ],
      ),
    );
  }
}
