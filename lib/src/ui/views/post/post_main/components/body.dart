import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/post_tab_btns.dart';
import 'post_list_tile.dart';

//여기서는 sliver을 써야해서 mainAppbar 못씀
class Body extends StatelessWidget {
  final PostMainScreenViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        displacement: 150,
        onRefresh: () => vm.refreshPostAfterCreateUpdate(),
        child: CustomScrollView(
          controller: vm.postScrollController,
          slivers: [
            SliverAppBar(
              title: Text(
                '\t피드',
                style: TextStyle(
                    fontFamily: 'Gmarket',
                    color: Colors.black,
                    fontSize: resizeFont(20),
                    fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/postCreate');
                  },
                  icon: const Icon(FontAwesomeIcons.penToSquare),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(FontAwesomeIcons.bell),
                  color: Colors.black,
                ),
              ],
              elevation: 0.0,
              backgroundColor: screenBackgroundColor,
              pinned: false,
              floating: true,
            ),
            SliverPersistentHeader(
              delegate: PostTabBtns(vm: vm),
              pinned: true,
            ),
            vm.busy
                ? SliverList(
                    // Use a delegate to build items as they're scrolled on screen.
                    delegate: SliverChildBuilderDelegate(
                      // The builder function returns a ListTile with a title that
                      // displays the index of the current item.
                      (context, index) => const IsLoading(),
                      // Builds 1000 ListTiles
                      childCount: 1,
                    ),
                  )
                : (vm.posts.isEmpty)
                    ? SliverList(
                        // Use a delegate to build items as they're scrolled on screen.
                        delegate: SliverChildBuilderDelegate(
                          // The builder function returns a ListTile with a title that
                          // displays the index of the current item.
                          (context, index) => const CenterSentence(
                            sentence: "등록된 게시글이 없습니다.",
                            verticalSpace: 50,
                          ),
                          // Builds 1000 ListTiles
                          childCount: 1,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                PostListTile(post: vm.posts[index]),
                            childCount: vm.posts.length),
                      )
          ],
        ));
  }
}
