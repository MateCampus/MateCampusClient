import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/ui/common_components/voice_bottom_sheet_component/voice_bottom_sheet.dart';

import '../../business_logic/utils/constants.dart';
import 'chat/chat_main/chat_main_screen.dart';
import 'mypage/mypage_main/mypage_main_screen.dart';
import 'post/post_main/post_main_screen.dart';
import 'voice/voice_main/voice_main_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    const VoiceMainScreen(),
    const PostMainScreen(),
    const ChatMainScreen(),
    const MypageMainScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  HomeViewModel vm = serviceLocator<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<HomeViewModel>(builder: (context, vm, child) {
          return Scaffold(
            body: PageStorage(
              child: vm.currentScreen,
              bucket: bucket,
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              backgroundColor: mainColor,
              onPressed: () {
                showCustomModalBottomSheet(context, const VoiceBottomSheet(), true);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            vm.changeCurrentIndex(0);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: vm.currentTab == 0
                                    ? mainColor
                                    : Colors.grey,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: vm.currentTab == 0
                                        ? mainColor
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            vm.changeCurrentIndex(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article,
                                color: vm.currentTab == 1
                                    ? mainColor
                                    : Colors.grey,
                              ),
                              Text(
                                '게시판',
                                style: TextStyle(
                                    color: vm.currentTab == 1
                                        ? mainColor
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            vm.changeCurrentIndex(2);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_rounded,
                                color: vm.currentTab == 2
                                    ? mainColor
                                    : Colors.grey,
                              ),
                              Text(
                                '채팅',
                                style: TextStyle(
                                    color: vm.currentTab == 2
                                        ? mainColor
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            vm.changeCurrentIndex(3);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: vm.currentTab == 3
                                    ? mainColor
                                    : Colors.grey,
                              ),
                              Text(
                                '마이페이지',
                                style: TextStyle(
                                    color: vm.currentTab == 3
                                        ? mainColor
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
