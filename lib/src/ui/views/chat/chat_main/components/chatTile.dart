import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

class ChatTile extends StatefulWidget {
  final ChatRoom chatRoom;
  final Animation<double> animation;
  final VoidCallback onClicked;
  final VoidCallback onDeleted;
  ChatTile(
      {required this.chatRoom,
      required this.animation,
      required this.onClicked,
      required this.onDeleted});

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      key: ValueKey(widget.chatRoom.imageUrl), // 변경 필요.
      sizeFactor: widget.animation,
      child: buildItem(context),
    );
  }

  Widget buildItem(BuildContext context) => Column(
        children: [
          ListTile(
              // onLongPress: widget.onDeleted,
              onTap: widget.onClicked,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5)),
              minVerticalPadding: 0,
              dense: true,
              visualDensity: VisualDensity(horizontal: -2),
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: getProportionateScreenWidth(23),
                // TODO: aws 이미지 403이면 일반 이미지 보여주도록 구현해야함.
                // backgroundImage: widget.chatRoom.image.image ??
                //     Image.asset(
                //             "assets/images/background/hanriver_chicken.jpeg")
                //         .image),
                // TODO: presentation으로 변경해야함.
                backgroundImage: widget.chatRoom.imageUrl != null
                    ? (widget.chatRoom.imageUrl!.startsWith('https')
                        ? CachedNetworkImageProvider(widget.chatRoom.imageUrl!)
                            as ImageProvider
                        : AssetImage(
                            widget.chatRoom.imageUrl!,
                          ))
                    : const AssetImage("assets/images/user/general_user.png"),
              ),
              title: Text(
                widget.chatRoom.title,
                style: TextStyle(
                    fontSize: resizeFont(14),
                    color: Color(0xff111111),
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(
                widget.chatRoom.lastMessage,
                maxLines: 1,
                style: TextStyle(
                  fontSize: resizeFont(13),
                  color: Color(0xff767676),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //createdAt -> date_convert에서 데이터 변환
                    Text(
                      dateToElapsedTimeOnChatMain(
                          widget.chatRoom.lastMsgCreatedAt),
                      style: TextStyle(
                          fontSize: kCreateAtFontSize,
                          color: Color(0xff767676),
                          fontWeight: FontWeight.w300),
                    ),
                    // ** TODO: unread 부분 수정
                    widget.chatRoom.unreadCount == 0
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(
                                top: getProportionateScreenHeight(5)),
                            child: Container(
                              width: getProportionateScreenHeight(18),
                              height: getProportionateScreenHeight(18),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: kMainColor),
                              child: Center(
                                child: Text(
                                  widget.chatRoom.unreadCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: resizeFont(10),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          )
                  ])),
          const HorizontalDividerCustom(
            color: Color(0xfff0f0f6),
          )
        ],
      );
}
