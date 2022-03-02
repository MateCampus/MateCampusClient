import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';

class FriendListTile extends StatelessWidget {
  FriendPresentation user;
  FriendListTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user.imageUrl),
        Text(user.nickname),
      ],
    );
  }
}
