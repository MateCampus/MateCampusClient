import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/voice_room_create_bottom_sheet_component/voice_room_create_bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageStorageBucket bucket = PageStorageBucket();
  HomeViewModel vm = serviceLocator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider.value(
        value: vm,
        child: Consumer<HomeViewModel>(builder: (context, vm, child) {
          return Scaffold(
            body: PageStorage(
              child: vm.currentScreen,
              bucket: bucket,
            ),
            floatingActionButton: Container(
              height: 50,
              width: 50,
              child: FittedBox(
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: getProportionateScreenWidth(30),
                  ),
                  backgroundColor: kMainColor,
                  onPressed: () {
                    showCustomModalBottomSheet(
                        context: context,
                        buildWidget: const VoiceRoomCreateBottomSheet());
                  },
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: getProportionateScreenWidth(5),
              elevation: 4,
              child: SizedBox(
                height: getProportionateScreenHeight(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          //minWidth: getProportionateScreenWidth(40),
                          onPressed: () {
                            vm.changeCurrentIndex(0);
                          },
                          child: vm.currentTab == 0
                              ? Icon(
                                  CupertinoIcons.house_alt_fill,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black87,
                                )
                              : Icon(
                                  CupertinoIcons.house_alt,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black54,
                                ),
                        ),
                        MaterialButton(
                          //minWidth: getProportionateScreenWidth(40),
                          onPressed: () {
                            vm.changeCurrentIndex(1);
                          },
                          child: vm.currentTab == 1
                              ? Icon(
                                  CupertinoIcons.square_favorites_alt_fill,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black87,
                                )
                              : Icon(
                                  CupertinoIcons.square_favorites_alt,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black54,
                                ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          // minWidth: getProportionateScreenWidth(40),
                          onPressed: () {
                            vm.changeCurrentIndex(2);
                          },
                          child: vm.currentTab == 2
                              ? Icon(
                                  CupertinoIcons.ellipses_bubble_fill,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black87,
                                )
                              : Icon(
                                  CupertinoIcons.ellipses_bubble,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black54,
                                ),
                        ),
                        MaterialButton(
                          // minWidth: getProportionateScreenWidth(40),
                          onPressed: () {
                            vm.changeCurrentIndex(3);
                          },
                          child: vm.currentTab == 3
                              ? Icon(
                                  CupertinoIcons.person_fill,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black87,
                                )
                              : Icon(
                                  CupertinoIcons.person,
                                  size: getProportionateScreenWidth(25),
                                  color: Colors.black54,
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
