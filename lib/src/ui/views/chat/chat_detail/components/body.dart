import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_shadow.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  ChatDetailViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vm.busy
        ? const CircularProgressIndicator()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vm.loadMoreBusy
                  ? const HorizontalDividerCustom(
                      thickness: 5,
                    )
                  : Container(),
              Expanded(
                //이거 때문에 자꾸 채팅방 키보드 내려갔을 때 젤 밑에 공간생김.. 근데 expanded없이는 하단에 채팅입력바를 고정시킬 수 없음(아직 방법 못찾음..)
                child: Scrollbar(
                    controller: vm.scrollController,
                    thickness: 3,
                    child: Container(
                      alignment: Alignment.bottomCenter,
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
              DefaultShadowBox(
                backgroundColor: const Color(0xfffff8f3),
                child: Padding(
                  padding: defaultPadding,
                  child: ChatInputField(
                    roomId: vm.chatRoom.roomId,
                    roomType: vm.chatRoom.type,
                  ),
                ),
              )
            ],
          );
  }
}
