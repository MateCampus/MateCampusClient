import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/components/body.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({Key? key}) : super(key: key);

  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  PostCreateScreenViewModel vm = serviceLocator<PostCreateScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<PostCreateScreenViewModel>(
        create: (context) => vm,
        child:
            Consumer<PostCreateScreenViewModel>(builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: Scaffold(
              appBar: SubAppbar(
                titleText: '글쓰기',
                isCenter: true,
                actions: [
                  TextButton(
                    onPressed: () {
                      vm.createPost(context);
                    },
                    child: const Text('등록'),
                    style: TextButton.styleFrom(
                      primary: mainColor,
                    ),
                  )
                ],
              ),
              backgroundColor: Colors.white,
              body: Body(vm: vm),
            ),
          );
        }));
  }
}
