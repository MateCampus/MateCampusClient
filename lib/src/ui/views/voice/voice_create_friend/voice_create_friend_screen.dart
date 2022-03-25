import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/my_friend_body.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/recent_talk_body.dart';

class VoiceCreateFriendScreen extends StatefulWidget {
  const VoiceCreateFriendScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCreateFriendScreen> createState() =>
      _VoiceCreateFriendScreenState();
}

class _VoiceCreateFriendScreenState extends State<VoiceCreateFriendScreen> {
  VoiceFriendFormScreenViewModel vm =
      serviceLocator<VoiceFriendFormScreenViewModel>();
  @override
  void initState() {
    vm.loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    final args = ModalRoute.of(context)!.settings.arguments
        as VoiceCreateFriendScreenArgs;

    return ChangeNotifierProvider<VoiceFriendFormScreenViewModel>(
        create: (context) => vm,
        child: Consumer<VoiceFriendFormScreenViewModel>(
            builder: (context, model, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('대화친구 선택',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  centerTitle: false,
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  bottom: TabBar(
                      indicatorColor: args.color,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelColor: const Color(0xff7f7f7f),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      tabs: const [Tab(text: '최근 대화'), Tab(text: '내 친구')]),
                ),
                backgroundColor: Colors.white, //배경색
                body: TabBarView(children: [
                  RecentTalkBody(
                    vm: vm,
                    color: args.color,
                  ),
                  MyFriendBody(
                    vm: vm,
                    color: args.color,
                  )
                ]),
              ),
            ),
          );
        }));
  }
}
