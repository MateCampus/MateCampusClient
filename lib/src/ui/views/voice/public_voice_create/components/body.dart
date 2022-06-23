import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/disabled_default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/category_select_line.dart';
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
                  CategorySelectLine(
                    vm: vm,
                    from: "voice",
                  ),
                  const VerticalSpacing(of: 10),
                  // TagCategory(vm: vm),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: BottomFixedBtnDecoBox(
            child: vm.titleController.text.length < 5
                ? const DisabledDefaultBtn(text: '다음')
                : DefaultBtn(
                    text: '다음',
                    press: () {
                      if (vm.categoryCodeList.length < 1) {
                        toastMessage("최소 1개의 카테고리를 선택해주세요.");
                        return;
                      }

                      /// title이 선택되면 button 색깔도 변경되도록 구현.
                      Navigator.pushNamed(context, "/voiceCreateFriend",
                          arguments: VoiceCreateFriendScreenArgs(kMainColor));
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
