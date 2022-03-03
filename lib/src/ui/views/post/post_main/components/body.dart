import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'post_list_tile.dart';

class Body extends StatelessWidget {
  PostMainScreenViewModel vm;
  Body({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  vm.changeType(0);
                  vm.loadPost();
                  print(vm.sortType);
                },
                child: Text('인기'),
              ),
              TextButton(
                  onPressed: () {
                    vm.changeType(1);
                    vm.loadPost();
                    print(vm.sortType);
                  },
                  child: Text('추천')),
              TextButton(
                  onPressed: () {
                    vm.changeType(2);
                    vm.loadPost();
                    print(vm.sortType);
                  },
                  child: Text('최신'))
            ],
          ),
          Column(children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostListTile(post: vm.posts[index]);
                }),
            // TODO : 게시글이 아예 없는 경우, loading되는 상태,
            vm.busy
                ? SizedBox(
                    height: getProportionateScreenHeight(400),
                    child: const Center(
                      child:
                          CircularProgressIndicator(), //모델이 뭔가 일을 하고 있으면 그 로딩중 창 띄우는 거 같음
                    ))
                : (vm.posts.isEmpty
                    ? const CenterSentence(
                        sentence: "등록된 게시글이 없습니다.",
                        verticalSpace: 50,
                      )
                    : Container()),
          ]),
        ],
      ),
    );
  }
}

class TabBtn extends StatelessWidget {
  final String tabtitle;

  TabBtn({required this.tabtitle});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: () {},
      child: Text(tabtitle),
    );
  }
}
