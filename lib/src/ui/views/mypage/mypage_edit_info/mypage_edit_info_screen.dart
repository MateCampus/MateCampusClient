import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/components/body.dart';

class MypageEditInfoScreen extends StatefulWidget {
  const MypageEditInfoScreen({Key? key}) : super(key: key);

  @override
  _MypageEditInfoScreenState createState() => _MypageEditInfoScreenState();
}

class _MypageEditInfoScreenState extends State<MypageEditInfoScreen> {
  MypageViewModel vm = serviceLocator<MypageViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypageViewModel>.value(
      value: vm,
      child: Consumer<MypageViewModel>(builder: (context, vm, child) {
        return GestureDetector(
          onTap: () =>
              FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
          child: Scaffold(
            appBar: AppBar(
              title: const Text('프로필 편집',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Body(vm: vm),
          ),
        );
      }),
    );
  }
}
