import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/chat_list.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/chat_top_banner.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/friend_btn.dart';

import 'chatTile.dart';

class Body extends StatelessWidget {
  final ChatViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        ChatTopBanner(),
        FriendBtn(),
        const VerticalSpacing(of: 15),
        ChatList(vm: vm)
      ],
    ));
  }
}
