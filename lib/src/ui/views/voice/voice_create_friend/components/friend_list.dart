import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/friend_list_tile.dart';

class FriendList extends StatelessWidget {
  VoiceFriendFormScreenViewModel vm;
  List<FriendPresentation> users;
  FriendList({Key? key, required this.vm, required this.users})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return FriendListTile(user: users[index]);
        });
  }
}
