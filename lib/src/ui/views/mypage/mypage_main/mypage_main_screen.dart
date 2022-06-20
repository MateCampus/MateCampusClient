import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/main_appbar_components/main_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/body.dart';

class MypageMainScreen extends StatefulWidget {
  const MypageMainScreen({Key? key}) : super(key: key);

  @override
  State<MypageMainScreen> createState() => _MypageMainScreenState();
}

class _MypageMainScreenState extends State<MypageMainScreen> {
  MypageViewModel vm = serviceLocator<MypageViewModel>();

  @override
  void initState() {
    vm.loadMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypageViewModel>.value(
      value: vm,
      child: Consumer<MypageViewModel>(builder: (context, vm, child) {
        return Scaffold(
            appBar: MainAppBar(
              titleText: '내정보',
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: const Icon(Icons.settings_outlined),
                  iconSize: kAppBarIconSizeG,
                  color: kAppBarIconColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.bell),
                  iconSize: kAppBarIconSizeFA,
                  color: kAppBarIconColor,
                ),
              ],
            ),
            backgroundColor: kMainScreenBackgroundColor,
            body: vm.busy ? const IsLoading() : Body(vm: vm));
      }),
    );
  }
}
