import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import '../../../../business_logic/utils/constants.dart';
import 'components/body.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({Key? key}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  ChatDetailViewModel vm = serviceLocator<ChatDetailViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    // 여기서 argument 잡아서 msg load랑 뭐시기 다 해야함.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<ChatDetailViewModel>(
        create: (context) => vm,
        child: Consumer<ChatDetailViewModel>(builder: (context, vm, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            behavior: HitTestBehavior.translucent,
            child: Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [subColor, mainColor],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
                leading: const BackButton(),
                centerTitle: true,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      vm.title,
                      style: TextStyle(
                          fontFamily: "SCDream5",
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.more_horiz_outlined,
                          color: Colors.white),
                      onPressed: () {})
                ],
              ),
              body: Body(vm: vm),
            ),
          );
        }));
  }
}
