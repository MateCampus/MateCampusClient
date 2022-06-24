import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/notification_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationPresentation notification;
  final Animation<double> animation;
  final VoidCallback onClicked;

  const NotificationListTile(
      {Key? key,
      required this.notification,
      required this.animation,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        key: ValueKey(notification.imageUrl),
        sizeFactor: animation,
        child: buildItem(context),
      );

  Widget buildItem(BuildContext context) => InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(5)),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: getProportionateScreenHeight(23),
            backgroundImage: notification.imageUrl.startsWith('https')
                ? CachedNetworkImageProvider(notification.imageUrl)
                    as ImageProvider
                : AssetImage(notification.imageUrl),
          ),
          title: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
                text: notification.nickname,
                style: TextStyle(
                    color: Colors.black87,
                    height: 1.0,
                    fontSize: getProportionateScreenWidth(13),
                    fontWeight: FontWeight.w700),
                children: <TextSpan>[
                  TextSpan(
                      text: notification.body,
                      style: TextStyle(
                          color: Colors.black87,
                          height: 1.0,
                          letterSpacing: 1.0,
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.w500)),
                ]),
          ),
          subtitle: Text(
            notification.createdAt,
            style: TextStyle(fontSize: kCreateAtFontSize, color: Colors.grey),
          ),
          trailing: IconButton(
            padding:
                EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
            constraints: const BoxConstraints(),
            iconSize: getProportionateScreenWidth(18),
            icon: const Icon(CupertinoIcons.trash, color: Colors.grey),
            onPressed: () {
              _deleteNotification(context);
            },
          ),
        ),
      );

  _deleteNotification(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            '삭제하기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            onClicked();
            Navigator.pop(context);
          },
        )
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(
                fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
