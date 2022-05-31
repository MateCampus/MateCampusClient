import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  Widget buildItem(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(5)),
        child: Container(
          //height: getProportionateScreenHeight(76),
          //width: getProportionateScreenWidth(335),
          // padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: ListTile(
              onTap: widget.onClicked,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              leading: CircleAvatar(
                radius: getProportionateScreenWidth(25),
                // TODO: aws 이미지 403이면 일반 이미지 보여주도록 구현해야함.
                // backgroundImage: widget.chatRoom.image.image ??
                //     Image.asset(
                //             "assets/images/background/hanriver_chicken.jpeg")
                //         .image),
                backgroundImage: widget.chatRoom.imageUrl.startsWith('https')
                    ? CachedNetworkImageProvider(widget.chatRoom.imageUrl)
                        as ImageProvider
                    : AssetImage(
                        widget.chatRoom.imageUrl,
                      ),
              ),
              title: Text(
                widget.chatRoom.title,
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w700),
              ),

              // RichText(
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              //   text: TextSpan(
              //       text: widget.chatRoom.title,
              //       style: const TextStyle(
              //           color: Colors.black,
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold),
              //       children: const <TextSpan>[]),
              // ),
              subtitle: Container(
                //padding: EdgeInsets.only(top: 5),
                child: Text(
                  widget.chatRoom.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeago.format(widget.chatRoom.lastMsgCreatedAt,
                          locale: 'ko'),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const VerticalSpacing(of: 10),
                    // ** TODO: unread 부분 수정
                    widget.chatRoom.unreadCount == 0
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.redAccent,
                            child: Text(
                              widget.chatRoom.unreadCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            )),
                  ])),
        ),
      );
}
