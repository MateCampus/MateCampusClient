import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_invite_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/my_friend_body.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/components/recent_talk_body.dart';

class VoiceInviteFriendScreen extends StatefulWidget {
  static const routeName = '/voiceInviteFriend';
  final int voiceRoomId;
  const VoiceInviteFriendScreen({Key? key, required this.voiceRoomId})
      : super(key: key);

  @override
  State<VoiceInviteFriendScreen> createState() =>
      _VoiceInviteFriendScreenState();
}

class _VoiceInviteFriendScreenState extends State<VoiceInviteFriendScreen> {
  VoiceInviteViewModel vm = serviceLocator<VoiceInviteViewModel>();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.loadRecentTalkUsersAndFriends(widget.voiceRoomId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<VoiceInviteViewModel>.value(
        value: vm,
        child: Consumer<VoiceInviteViewModel>(builder: (context, vm, child) {
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
                        indicatorColor: mainColor,
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
                    color: mainColor,
                    isFrom: "invite",
                  ),
                  MyFriendBody(
                    vm: vm,
                    users: vm.searchedFriendUsers.isEmpty
                        ? vm.friendUsers
                        : vm.searchedFriendUsers,
                    color: mainColor,
                    isFrom: "invite",
                  )
                ]),
              ),
            ),
          );
        }));
  }
}
