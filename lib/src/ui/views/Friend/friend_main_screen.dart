import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/Friend/components/friend_list_body.dart';
import 'package:zamongcampus/src/ui/views/Friend/components/request_list_body.dart';

class FriendMainScreen extends StatefulWidget {
  const FriendMainScreen({Key? key}) : super(key: key);

  @override
  _FriendMainScreenState createState() => _FriendMainScreenState();
}

class _FriendMainScreenState extends State<FriendMainScreen> {
  FriendListViewModel vm = serviceLocator<FriendListViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.loadFriends();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider<FriendListViewModel>.value(
        value: vm,
        child: Consumer<FriendListViewModel>(builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: SubAppbar(
                  titleText: '내 친구',
                  actions: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.bars),
                      iconSize: kAppBarIconSizeCP,
                      color: Colors.black,
                      onPressed: () {},
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(getProportionateScreenHeight(40)),
                    child: TabBar(
                        indicatorColor: kMainColor,
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
                              child: const Tab(text: '친구 목록')),
                          SizedBox(
                              height: getProportionateScreenHeight(30),
                              child: const Tab(text: '친구 신청'))
                        ]),
                  ),
                ),

                backgroundColor: kSubScreenBackgroundColor, //배경색
                body: TabBarView(children: [
                  FriendListBody(
                      vm: vm,
                      friends: vm.searchedFriends.isEmpty
                          ? vm.friendsIRequestAndAceepted
                          : vm.searchedFriends),
                  RequestListBody(vm: vm, friends: vm.friendsIReceived)
                ]),
              ),
            ),
          );
        }));
  }
}
