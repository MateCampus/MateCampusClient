import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/voice_room_create_bottom_sheet_component/components/create_private_voice_room_btn.dart';
import 'package:zamongcampus/src/ui/common_components/voice_room_create_bottom_sheet_component/components/create_public_voice_room_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/custom_drag_bar.dart';

class VoiceRoomCreateBottomSheet extends StatelessWidget {
  const VoiceRoomCreateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Container(
      height: getProportionateScreenHeight(250),
      decoration: const BoxDecoration(
          color: kSubScreenBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        children: [
          const CustomDragBar(),
          Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
                bottom: getProportionateScreenHeight(30)),
            child: Text(
              '어떤 대화방을 만드시겠어요?',
              style: TextStyle(
                  fontFamily: 'Gmarket',
                  color: Colors.black,
                  fontSize: kTitleFontSize,
                  fontWeight: FontWeight.w500),
            ),
          ),
          //const VerticalSpacing(of: 20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CreatePublicVoiceRoomBtn(),
                CreatePrivateVoiceRoomBtn()
              ],
            ),
          )
        ],
      ),
    );
  }
}
