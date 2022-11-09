import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  ChatDetailViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vm.busy
        ? const IsLoading()
        : Column(
            children: [
              vm.loadMoreBusy
                  ? const HorizontalDividerCustom(
                      thickness: 5,
                    )
                  : Container(),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
                  decoration: BoxDecoration(color: Color(0xfff1f1f5)),
                  child: SingleChildScrollView(
                    reverse: true,
                    controller: vm.scrollController,
                    child: Scrollbar(
                        controller: vm.scrollController,
                        thickness: 3,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              padding: EdgeInsets.zero,
                              itemCount: vm.chatMessages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Message(
                                    message: vm.chatMessages[index], vm: vm);
                              }),
                        )),
                  ),
                ),
              ),
              BottomFixedBtnDecoBox(
                backgroundColor: Colors.white,
                child: ChatInputField(
                  roomId: vm.chatRoom.roomId,
                  roomType: vm.chatRoom.type,
                ),
              )
            ],
          );
  }
}
