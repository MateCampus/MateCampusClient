import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/bottom_fixed_btn_decobox.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/text_chat_input_field.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/text_chat_message.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/voice_chat.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/voice_room_head.dart';

class Body extends StatefulWidget {
  final VoiceDetailViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VoiceRoomHead(voiceRoom: widget.vm.voiceRoom),
        VoiceChat(vm: widget.vm),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(children: [
              Container(
                margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                height: (widget.vm.voiceRoomMembers.length < 5)
                    ? getProportionateScreenHeight(425)
                    : getProportionateScreenHeight(317),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: [kDefaultShadowOnlyTop]),
                child: ListView.builder(
                    controller: widget.vm.textChatScrollController,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.vm.textChatMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TextChatMessage(
                          message: widget.vm.textChatMessages[index],
                          vm: widget.vm);
                    }),
              ),
              _textChatNotice()
            ]),
          ),
        ),
        SafeArea(
            child:
                BottomFixedBtnDecoBox(child: TextChatInputField(vm: widget.vm)))
      ],
    );
  }

  Widget _textChatNotice() {
    return Positioned(
      top: getProportionateScreenHeight(10),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(5),
            vertical: getProportionateScreenHeight(5)),
        height: getProportionateScreenHeight(50),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(),
          decoration: const BoxDecoration(
              color: Color(0xffFFE8D8),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            '공지? 소개글? 뭐라고 적어야하지...',
            style: TextStyle(
                fontSize: resizeFont(13), fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
