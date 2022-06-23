import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/models/chatMessage.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class TextChatMessage extends StatelessWidget {
  final ChatMessage message;
  final VoiceDetailViewModel vm;
  const TextChatMessage({Key? key, required this.message, required this.vm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageUrl = loginIdToImageUrl(message.loginId);
    String _nickname = loginIdToNickname(message.loginId);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: getProportionateScreenWidth(17),
            backgroundImage: _imageUrl.startsWith('https')
                ? CachedNetworkImageProvider(_imageUrl) as ImageProvider
                : AssetImage(_imageUrl),
          ),
          const HorizontalSpacing(of: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _nickname,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: resizeFont(13),
                          fontWeight: FontWeight.w700),
                    ),
                    const HorizontalSpacing(of: 5),
                    Text(
                      dateToTime(message.createdAt),
                      style: TextStyle(
                          fontSize: kCreateAtFontSize, color: Colors.grey),
                    ),
                  ],
                ),
                const VerticalSpacing(of: 3),
                Text(
                  message.text,
                  maxLines: null,
                  style: TextStyle(fontSize: resizeFont(13), height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String loginIdToNickname(String loginId) {
    String nickname = '';
    for (TextChatPresentation member in vm.textChatMembers) {
      if (member.loginId == loginId) {
        nickname = member.nickname;
        break;
      } else {
        nickname = '';
      }
    }
    return nickname;
  }

  String loginIdToImageUrl(String loginId) {
    String imageUrl = '';
    for (TextChatPresentation member in vm.textChatMembers) {
      if (member.loginId == loginId) {
        imageUrl = member.imageUrl;
        break;
      } else {
        imageUrl = '';
      }
    }
    return imageUrl;
  }
}
