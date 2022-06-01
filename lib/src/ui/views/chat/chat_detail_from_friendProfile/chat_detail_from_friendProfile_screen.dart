import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_from_friendProfile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

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
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: const Color(0xfffff8f3).withOpacity(0.9),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_outlined),
                  iconSize: getProportionateScreenHeight(20),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                title: Text(
                  vm.chatRoom.title,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz_outlined),
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
