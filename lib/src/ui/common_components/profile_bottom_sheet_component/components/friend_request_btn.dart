import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';

class FriendRequestBtn extends StatefulWidget {
  ProfileViewModel vm;
  FriendRequestBtn({Key? key, required this.vm}) : super(key: key);

  @override
  _FriendRequestBtnState createState() => _FriendRequestBtnState();
}

class _FriendRequestBtnState extends State<FriendRequestBtn> {
  @override
  Widget build(BuildContext context) {
    return DefaultShadowBox(
      child: Padding(
        padding: defaultPadding,
        child: DefaultBtn(
          text: '친구 신청',
          press: () {
            widget.vm.requestFriend('userId', widget.vm.profile.loginId);
          },
        ),
      ),
    );
  }
}
