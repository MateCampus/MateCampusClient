import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
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
            appBar: SubAppbar(
              titleText: '프로필 수정',
              isCenter: true,
              actions: [
                (vm.isValidNickname ||
                        vm.isValidIntroduction ||
                        vm.changedProfileImgPath.isNotEmpty)
                    ? //활성화 버튼
                    _editInfoBtn()
                    : //비활성화 버튼
                    _editInfoBtnDisable(),
              ],
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: Body(vm: vm),
          ),
        );
      }),
    );
  }

  Widget _editInfoBtn() {
    return TextButton(
      onPressed: () {
        vm.updateMyInfo(context: context);
      },
      child: const Text('완료하기'),
      style: TextButton.styleFrom(
          primary: kMainColor,
          textStyle:
              TextStyle(fontSize: resizeFont(14), fontWeight: FontWeight.w700)),
    );
  }

  Widget _editInfoBtnDisable() {
    return TextButton(
      onPressed: null,
      child: const Text('완료하기'),
      style: TextButton.styleFrom(
          primary: kMainColor,
          textStyle:
              TextStyle(fontSize: resizeFont(14), fontWeight: FontWeight.w700)),
    );
  }
}
