import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_create_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/my_friend_body.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/recent_talk_body.dart';

class VoiceCreateFriendScreen extends StatefulWidget {
  const VoiceCreateFriendScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCreateFriendScreen> createState() =>
      _VoiceCreateFriendScreenState();
}

class _VoiceCreateFriendScreenState extends State<VoiceCreateFriendScreen> {
  VoiceCreateViewModel vm = serviceLocator<VoiceCreateViewModel>();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.loadRecentTalkUsersAndFriends();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    final args = ModalRoute.of(context)!.settings.arguments
        as VoiceCreateFriendScreenArgs;

    return ChangeNotifierProvider<VoiceCreateViewModel>.value(
        value: vm,
        child: Consumer<VoiceCreateViewModel>(builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: SubAppbar(
                  titleText: '대화친구 선택',
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(getProportionateScreenHeight(40)),
                    child: TabBar(
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
                        tabs: [
                          SizedBox(
                              height: getProportionateScreenHeight(30),
                              child: const Tab(text: '최근 대화')),
                          SizedBox(
                              height: getProportionateScreenHeight(30),
                              child: const Tab(text: '내 친구'))
                        ]),
                  ),
                ),

                backgroundColor: Colors.white, //배경색
                body: TabBarView(children: [
                  RecentTalkBody(
                    vm: vm,
                    users: vm.searchedRecentUsers.isEmpty
                        ? vm.recentTalkUsers
                        : vm.searchedRecentUsers,
                    color: args.color,
                    isFrom: "create",
                  ),
                  MyFriendBody(
                    vm: vm,
                    users: vm.searchedFriendUsers.isEmpty
                        ? vm.friendUsers
                        : vm.searchedFriendUsers,
                    color: args.color,
                    isFrom: "create",
                  )
                ]),
              ),
            ),
          );
        }));
  }
}
