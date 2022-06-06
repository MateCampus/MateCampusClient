import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_disable_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/check_options.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/tag_category.dart';
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
                  TitleInput(vm: vm),
                  const VerticalSpacing(of: 5),
                  CheckOptions(vm: vm),
                  const VerticalSpacing(of: 15),
                  TagCategory(vm: vm),
                ],
              ),
            ),
          ),
        ),
        DefaultShadowBox(
          child: Padding(
            padding: defaultPadding,
            child: vm.isValidTitle
                ? DefaultBtn(
                    text: '다음',
                    press: () {
                      Navigator.pushNamed(context, "/voiceCreateFriend",
                          arguments: VoiceCreateFriendScreenArgs(mainColor));
                    },
                  )
                : const DefaultDisalbeBtn(text: '다음'),
          ),
        ),
      ],
    );
  }
}
