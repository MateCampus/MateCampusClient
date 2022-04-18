import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';

class WaitingFriendRequest extends StatefulWidget {
  const WaitingFriendRequest({Key? key}) : super(key: key);

  @override
  _WaitingFriendRequestState createState() => _WaitingFriendRequestState();
}

class _WaitingFriendRequestState extends State<WaitingFriendRequest> {
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
          text: '수락 대기중',
          btnColor: Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}
