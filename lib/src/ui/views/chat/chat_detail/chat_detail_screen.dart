import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class ChatDetailScreen extends StatefulWidget {
  static const routeName = '/chatDetail';
  final ChatRoom chatRoom;
  final int index;
  const ChatDetailScreen(
      {Key? key, required this.chatRoom, required this.index})
      : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  ChatDetailViewModel vm = serviceLocator<ChatDetailViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.chatDetailInit(widget.chatRoom);
    });
    super.initState();
  }

  @override
  void dispose() {
    print('chatdetail dispose 시작한다잉');
    vm.resetData();
    ChatViewModel chatViewModel = serviceLocator<ChatViewModel>();
    chatViewModel.changeInsideRoomId("0");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<ChatDetailViewModel>(builder: (context, vm, child) {
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
