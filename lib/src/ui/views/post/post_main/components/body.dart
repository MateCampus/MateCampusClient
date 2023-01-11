import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/shimmer_components/main_loading/components/main_loading_list_tile.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/notification_alarm_in_appbar.dart';
import 'package:zamongcampus/src/ui/views/post/post_main/components/post_tab_btns.dart';
import 'post_list_tile.dart';

//여기서는 sliver을 써야해서 mainAppbar 못씀
class Body extends StatelessWidget {
  final PostMainScreenViewModel vm;
  const Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: vm.postMainKey,
        edgeOffset: getProportionateScreenHeight(110),
        displacement: 10,
        onRefresh: () => vm.refreshPostAfterCreateUpdate(),
        child: CustomScrollView(
          controller: vm.postScrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              centerTitle: false,
              title: Text(
                '\t피드',
                style: TextStyle(
                    fontFamily: 'Pretendard',
                    color: kAppBarTextColor,
                    fontSize: resizeFont(20),
                    // letterSpacing: 2,
                    fontWeight: FontWeight.w700),
              ),
              actions: const [
                NotificationAlarmInAppbar(
                  iconColor: kAppBarIconColor,
                )
              ],
              elevation: 0.0,
              backgroundColor: kMainScreenBackgroundColor,
              pinned: false,
              floating: true,
            ),
            SliverPersistentHeader(
              delegate: PostTabBtns(vm: vm),
              pinned: true,
            ),
            (vm.busy)
                ? SliverList(
                    // Use a delegate to build items as they're scrolled on screen.
                    delegate: SliverChildBuilderDelegate(
                      // The builder function returns a ListTile with a title that
                      // displays the index of the current item.
                      (context, index) => const MainLoadingListTile(),
                      // Builds 1000 ListTiles
                      childCount: 5,
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
                            topSpace: 50,
                          ),
                          // Builds 1000 ListTiles
                          childCount: 1,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => PostListTile(
                              vm: vm,
                                post: vm.posts[index],
                                refresh: () =>
                                    vm.postMainKey.currentState?.show()),
                            childCount: vm.posts.length),
                      )
          ],
        ));
  }
}
