import 'package:flutter/material.dart';
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
  PostMainScreenViewModel model = serviceLocator<PostMainScreenViewModel>();

  @override
  void initState() {
    model.loadPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<PostMainScreenViewModel>(
        create: (context) => model,
        child:
            Consumer<PostMainScreenViewModel>(builder: (context, model, child) {
          return Scaffold(body: Body(model: model));
        }));
  }
}
