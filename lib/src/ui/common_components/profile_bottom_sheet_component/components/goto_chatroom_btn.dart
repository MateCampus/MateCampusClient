import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';

class GoToChatRoomBtn extends StatefulWidget {
  String profileLoginId;
  GoToChatRoomBtn({Key? key, required this.profileLoginId}) : super(key: key);

  @override
  _GoToChatRoomBtnState createState() => _GoToChatRoomBtnState();
}

class _GoToChatRoomBtnState extends State<GoToChatRoomBtn> {
  @override
  Widget build(BuildContext context) {
    return DefaultShadowBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            getProportionateScreenWidth(20),
            getProportionateScreenHeight(10),
            getProportionateScreenWidth(20),
            getProportionateScreenHeight(25)),
        child: DefaultBtn(
          text: '대화 하기',
          press: () {}, //chatDetail로 navigate (로그인아이디 같은 인자를 넘겨서?)
        ),
      ),
    );
  }
}
