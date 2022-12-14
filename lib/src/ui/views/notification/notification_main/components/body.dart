import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/notification_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/chat_top_banner.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/components/notification_list_tile.dart';

class Body extends StatelessWidget {
  final NotificationViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  // final listKey = GlobalKey<AnimatedListState>();
  // final List<NotificationZC> items = List.from(notificationList);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const ChatTopBanner(), //광고
          vm.busy
              ? const IsLoading()
              : (vm.notifications.isEmpty)
                  ? const CenterSentence(
                      sentence: "알림이 존재하지 않습니다",
                      topSpace: 20,
                    )
                  : AnimatedList(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      key: vm.listKey,
                      initialItemCount: vm.notifications.length,
                      itemBuilder: (context, index, animation) =>
                          NotificationListTile(
                        notification: vm.notifications[index],
                        animation: animation,
                        onClicked: () {
                          vm.navigateAndSetRead(
                              vm.notifications[index], context, index);
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
