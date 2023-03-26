import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/notification_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationViewModel vm;
  final NotificationPresentation notification;
  final int index;
  final Animation<double> animation;
  // animateList 때문에 callback으로 둔 것. (chatscreen 참고)
  final VoidCallback onClicked;

  const NotificationListTile(
      {Key? key,
      required this.vm,
      required this.notification,
      required this.index,
      required this.animation,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        key: ValueKey(notification.imageUrl),
        sizeFactor: animation,
        child: buildItem(context),
      );

  Widget buildItem(BuildContext context) => ListTile(
        onTap: () {
          print('클릭이요');
          onClicked();
        },
        tileColor:
            notification.isUnRead ? kMainColor.withOpacity(0.1) : Colors.white,
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenHeight(5)),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: getProportionateScreenHeight(20),
          backgroundImage: notification.imageUrl.startsWith('https')
              ? CachedNetworkImageProvider(notification.imageUrl)
                  as ImageProvider
              : AssetImage(notification.imageUrl),
        ),
        title: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          text: TextSpan(
              text: notification.title,
              style: TextStyle(
                  color: Color(0xff111111),
                  // height: 1.0,
                  letterSpacing: 0.1,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.w500),
                  
                  children: [
                    TextSpan(
                    text: '\n'+notification.nickname,
                    style: TextStyle(
                        fontSize: resizeFont(14),
                        color: kMainColor,
                        fontWeight: FontWeight.w500)),
                        TextSpan(
                    text: notification.typeText,
                    style: TextStyle(
                        fontSize: resizeFont(14),
                        color: Color(0xff111111),
                        fontWeight: FontWeight.w400)),

                  ]),
        ),
        subtitle: Text(
          notification.createdAt,
          style: TextStyle(fontSize: kCreateAtFontSize, color: Color(0xff767676)),
        ),
        //지금 알림 리스트에서 삭제하게끔은 되어있는데, 다시 로드하면 그대로인 문제가 있음. 해결하기 전까지 delete막아둔다. 
        // trailing: IconButton(
        //   padding:
        //       EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
        //   constraints: const BoxConstraints(),
        //   iconSize: getProportionateScreenWidth(15),

        //   icon: const Icon(CupertinoIcons.ellipsis_vertical, color: Color(0xff111111)),
        //   onPressed: () {
           
        //     _deleteNotification(context);
        //   },
        // ),
      );

  // _deleteNotification(BuildContext context) {
  //   showAdaptiveActionSheet(
  //     context: context,
  //     actions: <BottomSheetAction>[
  //       BottomSheetAction(
  //         title: Text(
  //           '삭제하기',
  //           style: TextStyle(
  //             fontSize: resizeFont(15.0),
  //             color: Colors.black87,
  //           ),
  //         ),
  //         onPressed: () {
  //           vm.removeItem(vm, index);
  //           // onClicked();
            
  //           Navigator.pop(context);
  //         },
  //       )
  //     ],
  //     cancelAction: CancelAction(
  //         title: Text(
  //           '취소',
  //           style: TextStyle(
  //               fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
  //         ),
  //         onPressed: () {
  //           Navigator.pop(context);
  //         }),
  //   );
  // }
}
