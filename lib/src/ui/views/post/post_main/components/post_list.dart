// import 'package:flutter/material.dart';
// import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
// import 'package:zamongcampus/src/config/size_config.dart';
// import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
// import 'package:zamongcampus/src/ui/views/post/post_main/components/post_list_tile.dart';

// class PostList extends StatelessWidget {
//   PostMainScreenViewModel vm;
//   List<PostPresentation> posts;
//   PostList({Key? key, required this.vm, required this.posts}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       vm.busy
//           ? SizedBox(
//               height: getProportionateScreenHeight(400),
//               child: const Center(
//                 child:
//                     CircularProgressIndicator(), 
//               ))
//           : (vm.posts.isEmpty
//               ? const CenterSentence(
//                   sentence: "등록된 게시글이 없습니다.",
//                   verticalSpace: 50,
//                 )
//               : Container()),
//       ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: vm.posts.length,
//           itemBuilder: (BuildContext context, int index) {
//             return PostListTile(post: vm.posts[index]);
//           }),
//       // TODO : 게시글이 아예 없는 경우, loading되는 상태,
//     ]);
//   }
// }
