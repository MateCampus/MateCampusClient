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
          return Scaffold(
              appBar: AppBar(
                title: const Text('피드',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                actions: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.edit_outlined),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.black,
                  ),
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Color(0xfff8f8f8),
              body: Body(model: model));
        }));
  }
}
