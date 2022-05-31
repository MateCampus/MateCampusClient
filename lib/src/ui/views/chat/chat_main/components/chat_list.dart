import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/chatTile.dart';

class ChatList extends StatelessWidget {
  final ChatViewModel vm;
  const ChatList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(5)),
            child: const Text(
              '채팅',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            )),
        AnimatedList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          key: vm.listKey,
          initialItemCount: vm.chatRooms.length,
          itemBuilder: (context, index, animation) => ChatTile(
              chatRoom: vm.chatRooms[index],
              animation: animation,
              onClicked: () {
                Navigator.pushNamed(context, "/chatDetail",
                    arguments:
                        ChatDetailScreenArgs(vm.chatRooms[index], index));
              },
              onDeleted: () {
                vm.removeItem(index, vm.chatRooms[index].roomId);
              }),
        ),
      ],
    );
  }
}
