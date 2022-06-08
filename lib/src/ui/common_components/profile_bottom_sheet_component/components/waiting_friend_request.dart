import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';

class WaitingFriendRequest extends StatefulWidget {
  const WaitingFriendRequest({Key? key}) : super(key: key);

  @override
  _WaitingFriendRequestState createState() => _WaitingFriendRequestState();
}

class _WaitingFriendRequestState extends State<WaitingFriendRequest> {
  @override
  Widget build(BuildContext context) {
    return BottomFixedBtnDecoBox(
      child: DefaultBtn(
        text: '수락 대기중',
        btnColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
