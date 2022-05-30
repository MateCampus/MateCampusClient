import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_from_friendProfile_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail/components/chat_input_field.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail/components/message.dart';

class Body extends StatelessWidget {
  ChatDetailFromFriendProfileViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vm.busy
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10.0),
            child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                )),
          )
        : Column(mainAxisSize: MainAxisSize.min, children: [
            vm.loadMoreBusy
                ? const HorizontalDividerCustom(
                    thickness: 5,
                  )
                : Container(),
            Expanded(
              child: Scrollbar(
                  controller: vm.scrollController,
                  thickness: 3,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 1.5),
                    child: ListView.builder(
                        controller: vm.scrollController,
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: vm.chatMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Message(
                              message: vm.chatMessages[index], vm: vm);
                        }),
                  )),
            ),
            ChatInputField(
                roomId: vm.chatRoom.roomId, roomType: vm.chatRoom.type)
          ]);
  }
}
