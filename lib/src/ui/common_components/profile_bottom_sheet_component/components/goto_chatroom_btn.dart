import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_from_friendProfile_screen_args.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail_from_friendProfile/chat_detail_from_friendProfile_screen.dart';

class GoToChatRoomBtn extends StatefulWidget {
  String profileLoginId;
  GoToChatRoomBtn({Key? key, required this.profileLoginId}) : super(key: key);

  @override
  _GoToChatRoomBtnState createState() => _GoToChatRoomBtnState();
}

class _GoToChatRoomBtnState extends State<GoToChatRoomBtn> {
  @override
  Widget build(BuildContext context) {
    return BottomFixedBtnDecoBox(
      child: DefaultBtn(
        text: '대화 하기',
        press: () {
          Navigator.pushNamed(
              context, ChatDetailFromFriendProfileScreen.routeName,
              arguments: ChatDetailFromFriendProfileScreenArgs(
                  profileLoginId: widget.profileLoginId));
        }, //chatDetail로 navigate (로그인아이디 같은 인자를 넘겨서?)
      ),
    );
  }
}
