import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_comment_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_comment/components/body.dart';

class MypageCommentScreen extends StatefulWidget {
  const MypageCommentScreen({Key? key}) : super(key: key);

  @override
  _MypageCommentScreenState createState() => _MypageCommentScreenState();
}

class _MypageCommentScreenState extends State<MypageCommentScreen> {
  MypageCommentViewModel vm = serviceLocator<MypageCommentViewModel>();

  @override
  void initState() {
    vm.loadMyComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<MypageCommentViewModel>.value(
      value: vm,
      child: Consumer<MypageCommentViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: SubAppbar(
              titleText: "내 댓글",
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: SafeArea(
                child: vm.busy
                    ? const IsLoading()
                    : vm.comments.isEmpty
                        ? const CenterSentence(
                            sentence: '댓글이 존재하지 않습니다',
                            bottomSpace: 100,
                          )
                        : Body(vm: vm, commentList: vm.comments)),
          );
        },
      ),
    );
  }
}
