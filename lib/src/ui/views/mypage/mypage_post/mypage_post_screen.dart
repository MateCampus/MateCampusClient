import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_post_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_post/components/body.dart';

class MypagePostScreen extends StatefulWidget {
  static const routeName = '/mypagePost';
  final String isFrom;
  const MypagePostScreen({Key? key, required this.isFrom}) : super(key: key);

  @override
  _MypagePostScreenState createState() => _MypagePostScreenState();
}

class _MypagePostScreenState extends State<MypagePostScreen> {
  MypagePostViewModel vm = serviceLocator<MypagePostViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    serviceLocator.resetLazySingleton<MypagePostViewModel>(instance: vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypagePostViewModel>.value(
      value: vm,
      child: Consumer<MypagePostViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: SubAppbar(
              titleText: (widget.isFrom == "BookMark") ? "북마크" : "내 피드",
              isCenter: true,
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: SafeArea(
                child: vm.busy
                    ? const IsLoading()
                    : vm.myPosts.isEmpty
                        ? const CenterSentence(
                            sentence: '게시물이 존재하지 않습니다',
                            bottomSpace: 100,
                          )
                        : Body(
                            vm: vm,
                          )),
          );
        },
      ),
    );
  }
}
