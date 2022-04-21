import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/auth/auth_service.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_main/components/body.dart';

class MypageMainScreen extends StatefulWidget {
  const MypageMainScreen({Key? key}) : super(key: key);

  @override
  State<MypageMainScreen> createState() => _MypageMainScreenState();
}

class _MypageMainScreenState extends State<MypageMainScreen> {
  MypageViewModel vm = serviceLocator<MypageViewModel>();
  final String _loginId = 'temp';

  @override
  void initState() {
    vm.loadMyInfo(_loginId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypageViewModel>.value(
      value: vm,
      child: Consumer<MypageViewModel>(builder: (context, vm, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('내정보',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              actions: [
                IconButton(
                  onPressed: () => {Navigator.pushNamed(context, '/settings')},
                  icon: const Icon(Icons.settings_outlined),
                  color: Colors.black,
                ),
                IconButton(
                  //알림버튼 -> 로그아웃으로 해둠
                  onPressed: () => {AuthService.logout(context)},
                  icon: const Icon(Icons.notifications_outlined),
                  color: Colors.black,
                ),
              ],
              elevation: 0.0,
              backgroundColor: const Color(0xfff8f8f8),
            ),
            backgroundColor: const Color(0xfff8f8f8),
            body: vm.busy ? const IsLoading() : Body(vm: vm));
      }),
    );
  }
}
