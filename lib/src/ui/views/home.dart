import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

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
  int currentTab = 0;
  final List<Widget> screens = [
    const VoiceMainScreen(),
    const PostMainScreen(),
    const ChatMainScreen(),
    const MypageMainScreen()
  ];

  //bottomsheet
  void _showModalBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: getProportionateScreenHeight(235),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(25)),
              child: Column(
                children: [
                  const Text(
                    '어떤 대화방을 만드시겠어요?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const VerticalSpacing(of: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/publicVoiceCreate");
                        },
                        child: SizedBox(
                          height: getProportionateScreenHeight(120),
                          width: getProportionateScreenWidth(150),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: getProportionateScreenHeight(70),
                                width: getProportionateScreenWidth(70),
                                decoration: const BoxDecoration(
                                    color: mainColor, shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.forum_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '공개 대화방',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '누구나 참여 가능',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/privateVoiceCreate");
                        },
                        child: SizedBox(
                          height: getProportionateScreenHeight(120),
                          width: getProportionateScreenWidth(150),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: getProportionateScreenHeight(70),
                                width: getProportionateScreenWidth(70),
                                decoration: const BoxDecoration(
                                    color: subColor, shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.lock_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                '비밀 대화방',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '친구만 참여 가능',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = VoiceMainScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        backgroundColor: mainColor,
        onPressed: () {
          _showModalBottomSheet();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                      setState(() {
                        currentScreen = screens[0];
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? mainColor : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0 ? mainColor : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = screens[1];
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          color: currentTab == 1 ? mainColor : Colors.grey,
                        ),
                        Text(
                          '게시판',
                          style: TextStyle(
                              color: currentTab == 1 ? mainColor : Colors.grey),
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
                      setState(() {
                        currentScreen = screens[2];
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: currentTab == 2 ? mainColor : Colors.grey,
                        ),
                        Text(
                          '채팅',
                          style: TextStyle(
                              color: currentTab == 2 ? mainColor : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = screens[3];
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? mainColor : Colors.grey,
                        ),
                        Text(
                          '마이페이지',
                          style: TextStyle(
                              color: currentTab == 3 ? mainColor : Colors.grey),
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
  }
}
