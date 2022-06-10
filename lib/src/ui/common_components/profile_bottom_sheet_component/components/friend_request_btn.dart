import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';

class FriendRequestBtn extends StatefulWidget {
  // TODO: userprofile과 일반 profile를 케이스에따라 받기에 var 변수로 뒀다.
  var vm;
  String profileLoginId;
  FriendRequestBtn({Key? key, required this.vm, required this.profileLoginId})
      : super(key: key);

  @override
  _FriendRequestBtnState createState() => _FriendRequestBtnState();
}

class _FriendRequestBtnState extends State<FriendRequestBtn> {
  @override
  Widget build(BuildContext context) {
    return BottomFixedBtnDecoBox(
      child: DefaultBtn(
        text: '친구 신청',
        press: () {
          widget.vm.requestFriend(widget.profileLoginId);
        },
      ),
    );
  }
}
