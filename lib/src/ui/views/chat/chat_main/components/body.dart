import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/services/chat/chat_service.dart';

import 'chatTile.dart';

class Body extends StatelessWidget {
  ChatViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimatedList(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: vm.listKey,
            initialItemCount: vm.chatRooms.length,
            itemBuilder: (context, index, animation) => ChatTile(
                chatRoom: vm.chatRooms[index],
                animation: animation,
                onClicked: () {
                  Navigator.pushNamed(context, "/chatDetail",
                          arguments:
                              ChatDetailScreenArgs(vm.chatRooms[index], index))
                      .then((value) => vm.changeInsideRoomId("0"));
                },
                onDeleted: () {
                  vm.removeItem(index, vm.chatRooms[index].roomId);
                }),
          )
        ],
      ),
    );
  }
}
