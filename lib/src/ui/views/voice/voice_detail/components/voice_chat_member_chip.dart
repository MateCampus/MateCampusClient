import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class VoiceChatMemberChip extends StatefulWidget {
  VoiceDetailViewModel vm;
  MemberPresentation member;
  VoiceChatMemberChip({Key? key, required this.vm, required this.member})
      : super(key: key);

  @override
  _VoiceChatMemberChipState createState() => _VoiceChatMemberChipState();
}

class _VoiceChatMemberChipState extends State<VoiceChatMemberChip> {
  @override
  Widget build(BuildContext context) {
    return widget.member.isHost ? _hostUser() : _generalUser();
  }

  Widget _hostUser() {
    return Column(
      children: [
        Stack(children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(3)),
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.member.isSpeaking
                        ? kMainColor
                        : Colors.grey.withOpacity(0.5),
                    width: 2.0,
                    style: BorderStyle.solid),
                shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: getProportionateScreenWidth(28),
              backgroundImage: widget.member.imageUrl.startsWith('https')
                  ? CachedNetworkImageProvider(widget.member.imageUrl)
                      as ImageProvider
                  : AssetImage(widget.member.imageUrl),
            ),
          ),
          Positioned(
            bottom: getProportionateScreenHeight(2),
            right: 0,
            child: Container(
              width: getProportionateScreenWidth(22),
              height: getProportionateScreenHeight(22),
              decoration: const BoxDecoration(
                  color: kMainColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                    )
                  ]),
              child: Icon(
                FontAwesomeIcons.crown,
                color: Colors.white,
                size: getProportionateScreenWidth(12),
              ),
            ),
          )
        ]),
        _nicknameBox()
      ],
    );
  }

  Widget _generalUser() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(getProportionateScreenWidth(3)),
          decoration: BoxDecoration(
              border: Border.all(
                  color: widget.member.isSpeaking
                      ? kMainColor
                      : Colors.grey.withOpacity(0.5),
                  width: 2.0,
                  style: BorderStyle.solid),
              shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: getProportionateScreenWidth(28),
            backgroundImage: widget.member.imageUrl.startsWith('https')
                ? CachedNetworkImageProvider(widget.member.imageUrl)
                    as ImageProvider
                : AssetImage(widget.member.imageUrl),
          ),
        ),
        _nicknameBox()
      ],
    );
  }

  Widget _nicknameBox() {
    return Container(
      width: getProportionateScreenWidth(60),
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Text(
        widget.member.nickname,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(10),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
