import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'chatTile.dart';

class Body extends StatelessWidget {
  ChatViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.grey.shade100,
          elevation: 4.0,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: getProportionateScreenHeight(30),
              backgroundImage:
                  const AssetImage('assets/images/user/general_user.png'),
            ),
            title: const Text('내 친구'),
            trailing: const Icon(
              Icons.chevron_right_outlined,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            onTap: () {
              Navigator.pushNamed(context, "/friend");
            },
          ),
        ),
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
    ));
  }
}
