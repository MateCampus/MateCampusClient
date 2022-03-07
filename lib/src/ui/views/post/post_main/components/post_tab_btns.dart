import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';

class PostTabBtns extends SliverPersistentHeaderDelegate {
  PostMainScreenViewModel vm;
  PostTabBtns({required this.vm});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xfff8f8f8),

      height: 70, //maxExtend, minExtend와 동일하게 해둠. -> 배경색 넣기위해 컨테이너 씀
      //margin: EdgeInsets.fromLTRB(20, 0, 20, 5), //Postlisttile 마진과 좌우 같게두기
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                vm.refreshPost(0);
              },
              child: Text(
                '인기',
                style: TextStyle(
                    color:
                        vm.sortType == "popular" ? Colors.white : Colors.grey),
              ),
              style: TextButton.styleFrom(
                  backgroundColor:
                      vm.sortType == "popular" ? mainColor : Colors.white,
                  minimumSize: const Size(48, 36),
                  side: vm.sortType == "popular"
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () {
                vm.refreshPost(1);
              },
              child: Text(
                '추천',
                style: TextStyle(
                    color: vm.sortType == "recommend"
                        ? Colors.white
                        : Colors.grey),
              ),
              style: TextButton.styleFrom(
                  backgroundColor:
                      vm.sortType == "recommend" ? mainColor : Colors.white,
                  minimumSize: const Size(48, 36),
                  side: vm.sortType == "recommend"
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () {
                vm.refreshPost(2);
              },
              child: Text(
                '최신',
                style: TextStyle(
                    color:
                        vm.sortType == "recent" ? Colors.white : Colors.grey),
              ),
              style: TextButton.styleFrom(
                  backgroundColor:
                      vm.sortType == "recent" ? mainColor : Colors.white,
                  minimumSize: const Size(48, 36),
                  side: vm.sortType == "recent"
                      ? null
                      : const BorderSide(color: Color(0xffe2e2e2))),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const Icon(Icons.tune, color: Colors.grey, size: 20.0),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(36, 36),
                  side: const BorderSide(color: Color(0xffe2e2e2)),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}


// class PostTabBtns extends StatelessWidget {
//   PostMainScreenViewModel vm;
//   PostTabBtns({Key? key, required this.vm}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       child: Row(
//         children: [
//           TextButton(
//             onPressed: () {
//               vm.refreshPost(0);
//               //PostList(vm: vm, posts: vm.posts);
//             },
//             child: Text(
//               '인기',
//               style: TextStyle(
//                   color: vm.sortType == "popular" ? Colors.red : Colors.blue),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               vm.refreshPost(1);
//               //PostList(vm: vm, posts: vm.posts);
//             },
//             child: Text(
//               '추천',
//               style: TextStyle(
//                   color: vm.sortType == "recommend" ? Colors.red : Colors.blue),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               vm.refreshPost(2);
//               // PostList(vm: vm, posts: vm.posts);
//             },
//             child: Text(
//               '최신',
//               style: TextStyle(
//                   color: vm.sortType == "recent" ? Colors.red : Colors.blue),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
