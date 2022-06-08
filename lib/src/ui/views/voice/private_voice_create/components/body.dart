import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/title_input.dart';

class Body extends StatelessWidget {
  final VoiceCreateViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleInput(vm: vm), //public_voice_create의 titleInput 사용
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: DefaultBtn(
              text: '다음',
              press: () {
                Navigator.pushNamed(context, "/voiceCreateFriend",
                    arguments: VoiceCreateFriendScreenArgs(subColor));
              },
              btnColor: subColor,
            ),
          ),
        ),
      ],
    );
  }
}
