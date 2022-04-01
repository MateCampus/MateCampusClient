import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/component/body.dart';

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
    vm.loadPostDetail(widget.postId);
    //print(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostDetailScreenViewModel>(
      create: (context) => vm,
      child: Consumer<PostDetailScreenViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
                title: const Text('글쓰기',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent),
            backgroundColor: Colors.white,
            body: Body(vm: vm),
          );
        },
      ),
    );
  }
}
