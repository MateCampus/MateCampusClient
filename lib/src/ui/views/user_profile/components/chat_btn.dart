import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_from_friendProfile_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail_from_friendProfile/chat_detail_from_friendProfile_screen.dart';

class ChatBtn extends StatefulWidget {
  String profileLoginId;
  ChatBtn({Key? key, required this.profileLoginId}) : super(key: key);

  @override
  _ChatBtnState createState() => _ChatBtnState();
}

class _ChatBtnState extends State<ChatBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        CupertinoIcons.chat_bubble_2,
        color: Colors.white,
      ),
      label: Text('채팅하기',
          style:
              TextStyle(fontSize: resizeFont(16), fontWeight: FontWeight.w700)),
      onPressed: () {
        Navigator.pushNamed(
            context, ChatDetailFromFriendProfileScreen.routeName,
            arguments: ChatDetailFromFriendProfileScreenArgs(
                profileLoginId: widget.profileLoginId));
      },
      style: ElevatedButton.styleFrom(
        primary: kMainColor,
        minimumSize: Size(
            getProportionateScreenWidth(254), getProportionateScreenHeight(56)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0)),
      ),
    );
  }
}
