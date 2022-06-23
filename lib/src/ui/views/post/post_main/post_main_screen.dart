import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:provider/provider.dart';

import '../../../../business_logic/view_models/post_main_screen_viewmodel.dart';
import 'components/body.dart';

class PostMainScreen extends StatefulWidget {
  const PostMainScreen({Key? key}) : super(key: key);

  @override
  State<PostMainScreen> createState() => _PostMainScreenState();
}

class _PostMainScreenState extends State<PostMainScreen> {
  PostMainScreenViewModel vm = serviceLocator<PostMainScreenViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.initData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider<PostMainScreenViewModel>.value(
        value: vm,
        child: Consumer<PostMainScreenViewModel>(builder: (context, vm, child) {
          return Scaffold(

              ///sliverAppbar를 쓰는데도 Appbar를 쓰는이유 -> SliverAppbar에서 설정한 backgroundColor가 safeArea때문에 statusBar 색까지 영향을 주지 못함.
              ///따라서 scaffold내에 Appbar를 넣고 color를 설정하면 컬러에 따라 statusBar색이 조정됨
              ///그런데 이미 쓰고 있는 SliverAppbar가 있기 때문에 Appbar의 크기를 0으로 준다. (toolbarHeight를 0으로 주면 됨. Appbar의 크기 결정은 결국 toolbarHeight를 곱한 값이기 때문)

              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: kMainScreenBackgroundColor,
                elevation: 0,
              ),
              backgroundColor: kMainScreenBackgroundColor,
              body: SafeArea(child: Body(vm: vm)));
        }));
  }
}
