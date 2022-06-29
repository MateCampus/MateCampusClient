import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
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
              title: Text(
                '\t피드',
                style: TextStyle(
                    fontFamily: 'Gmarket',
                    color: kAppBarTextColor,
                    fontSize: resizeFont(20),
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/postCreate');
                  },
                  icon: const Icon(FontAwesomeIcons.penToSquare),
                  iconSize: kAppBarIconSizeFA,
                  color: kAppBarIconColor,
                ),
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
                            topSpace: 50,
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
