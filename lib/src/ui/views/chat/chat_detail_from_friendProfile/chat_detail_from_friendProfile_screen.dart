import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_from_friendProfile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';

import 'components/body.dart';

class ChatDetailFromFriendProfileScreen extends StatefulWidget {
  static const routeName = '/chatDetailFromFriendProfile';
  final String profileLoginId;
  const ChatDetailFromFriendProfileScreen(
      {Key? key, required this.profileLoginId})
      : super(key: key);

  @override
  State<ChatDetailFromFriendProfileScreen> createState() =>
      _ChatDetailFromFriendProfileScreenState();
}

class _ChatDetailFromFriendProfileScreenState
    extends State<ChatDetailFromFriendProfileScreen> {
  ChatDetailFromFriendProfileViewModel vm =
      serviceLocator<ChatDetailFromFriendProfileViewModel>();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.chatDetailInit(widget.profileLoginId, context);
    });
    super.initState();
  }

  @override
  void dispose() {
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    chatViewModel.changeFromFriendProfile(false);
    chatViewModel.changeInsideRoomId("0");
    vm.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<ChatDetailFromFriendProfileViewModel>(
            builder: (context, vm, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            behavior: HitTestBehavior.translucent,
            child: Scaffold(
              appBar: SubAppbar(
                titleText: vm.chatRoom.title,
                isCenter: true,
                backgroundColor: kMainScreenBackgroundColor,
                actions: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis_vertical),
                    iconSize: kAppBarIconSizeCP,
                    color: Colors.black,
                    onPressed: () {
                      _chatOptions();
                    },
                  ),
                ],
              ),
              backgroundColor: kMainScreenBackgroundColor,
              body: SafeArea(child: Body(vm: vm)),
            ),
          );
        }));
  }

  //나가기 혹은 차단하기 용도
  _chatOptions() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            '차단하고 나가기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Color(0xff111111),
            ),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus
                ?.unfocus(); //혹시 키보드가 올라가있으면 내려준다.
            Navigator.pop(context);
            vm.blockUserAndExit();
            Navigator.pop(context);
          },
        ),
        BottomSheetAction(
          title: Text(
            '나가기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus
                ?.unfocus(); //혹시 키보드가 올라가있으면 내려준다.
            Navigator.pop(context);
            vm.exitChatRoom();
            Navigator.pop(context);
          },
        ),
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
