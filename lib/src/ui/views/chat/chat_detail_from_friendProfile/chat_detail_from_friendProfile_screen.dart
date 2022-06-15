import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      vm.chatDetailInit(widget.profileLoginId);
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
              extendBodyBehindAppBar: true,
              appBar: SubAppbar(
                titleText: vm.chatRoom.title,
                isCenter: true,
                backgroundColor: const Color(0xfffff8f3).withOpacity(0.9),
                actions: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis),
                    iconSize: getProportionateScreenHeight(20),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
              backgroundColor: const Color(0xfffff8f3),
              body: Body(vm: vm),
            ),
          );
        }));
  }
}
