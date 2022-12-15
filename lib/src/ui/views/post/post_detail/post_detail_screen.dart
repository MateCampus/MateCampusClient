import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/delete/post_deleted_msg.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report/report_form.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_post/report_post_form.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/body.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = '/postDetail';
  final int postId;
  const PostDetailScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostDetailScreenViewModel vm = serviceLocator<PostDetailScreenViewModel>();
  @override
  void initState() {
    vm.initData(widget.postId);
    super.initState();
  }

  @override
  void dispose() {
    serviceLocator.resetLazySingleton<PostDetailScreenViewModel>(instance: vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //vm.keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<PostDetailScreenViewModel>.value(
      value: vm,
      child: Consumer<PostDetailScreenViewModel>(
        builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: Scaffold(
              appBar: SubAppbar(
                leadingOnPress: () {
                  //혹시 overlay가 open된 채로 뒤로가기를 눌렀을 때 remove
                  vm.removeNestedCommentOverlay();
                  Navigator.of(context).pop();
                },
                titleText: '피드',
                isCenter: true,
                actions: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis_vertical),
                    color: Colors.black,
                    iconSize: kAppBarIconSizeCP,
                    onPressed: () {
                      _removeReportPost();
                    },
                  )
                ],
              ),

              backgroundColor: Colors.white,
              //extendBodyBehindAppBar: true,
              body: vm.busy ? const IsLoading() : Body(vm: vm),
            ),
          );
        },
      ),
    );
  }

  _removeReportPost() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        (vm.postDetail.loginId == AuthService.loginId)
            ? BottomSheetAction(
                title: Text(
                  '삭제하기',
                  style: TextStyle(
                    fontSize: resizeFont(15.0),
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  buildCustomAlertDialog(
                      context: context,
                      contentWidget: const PostDeletedMsg(),
                      btnText: '삭제',
                      press: () {
                        vm.deletePost(context, vm.postDetail.id);
                      });
                },
              )
            : BottomSheetAction(
                title: Text(
                  '신고하기',
                  style: TextStyle(
                    fontSize: resizeFont(15.0),
                    color: Colors.black87,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ReportForm(
                            targetUserLoginId: vm.postDetail.loginId,
                            reportCategoryIndex: "2");
                      });
                },
              ),
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(
                fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
