import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';

class GoToChatRoomBtn extends StatefulWidget {
  const GoToChatRoomBtn({Key? key}) : super(key: key);

  @override
  _GoToChatRoomBtnState createState() => _GoToChatRoomBtnState();
}

class _GoToChatRoomBtnState extends State<GoToChatRoomBtn> {
  @override
  Widget build(BuildContext context) {
    return DefaultShadowBox(
      child: Padding(
        padding: defaultPadding,
        child: DefaultBtn(
          text: '대화 하기',
          press: () {}, //chatDetail로 navigate (로그인아이디 같은 인자를 넘겨서?)
        ),
      ),
    );
  }
}
