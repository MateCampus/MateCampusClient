import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/voice/private_voice_create/components/title_input.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 5), //이부분 간격 체크,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  VerticalSpacing(),
                  TitleInput(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, getProportionateScreenHeight(10), 0,
                getProportionateScreenHeight(25)),
            child: DefaultBtn(
              text: '다음',
              press: () {
                Navigator.pushNamed(context, "/voiceCreateFriend",
                    arguments: VoiceCreateFriendScreenArgs(subColor));
              },
              btnColor: subColor,
            ),
          ),
        ],
      ),
    );
  }
}
