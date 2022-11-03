import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_liked_list_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/post/post_liked_list/components/body.dart';

class PostLikedListScreen extends StatefulWidget {
  static const routeName = '/postLikedList';
  final int postId;
  const PostLikedListScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _PostLikedListScreenState createState() => _PostLikedListScreenState();
}

class _PostLikedListScreenState extends State<PostLikedListScreen> {
  PostLikedListViewModel vm = serviceLocator<PostLikedListViewModel>();

  @override
  void initState() {
    vm.initData(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<PostLikedListViewModel>.value(
      value: vm,
      child: Consumer<PostLikedListViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: SubAppbar(
              titleText: '좋아요',
              isCenter: true,
            ),

            backgroundColor: Colors.white,
            //extendBodyBehindAppBar: true,
            body: vm.busy ? const IsLoading() : SafeArea(child: Body(vm: vm)),
          );
        },
      ),
    );
  }
}
