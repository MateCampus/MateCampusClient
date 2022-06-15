import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/main_appbar_components/main_appbar.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_main/components/body.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';

import 'components/body.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({Key? key}) : super(key: key);

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  ChatViewModel vm = serviceLocator<ChatViewModel>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<ChatViewModel>(builder: (context, vm, child) {
          return Scaffold(
            appBar: MainAppBar(
              titleText: '채팅',
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.maps_ugc_outlined),
                  iconSize: kAppBarIconSizeG,
                  color: kAppBarIconColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.bell,
                  ),
                  iconSize: kAppBarIconSizeFA,
                  color: kAppBarIconColor,
                ),
              ],
            ),
            backgroundColor: kMainScreenBackgroundColor,
            body: Body(vm: vm),
          );
        }));
  }
}
