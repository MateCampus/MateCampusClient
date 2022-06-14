import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class PostHead extends StatelessWidget {
  final PostDetailScreenViewModel vm;
  const PostHead({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vm.postDetail.categories.isEmpty
              ? const SizedBox()
              : Wrap(
                  alignment: WrapAlignment.start,
                  spacing: getProportionateScreenWidth(8),
                  children: [
                    ...vm.postDetail.categories.map((category) => Chip(
                          label: Text(category),
                          labelStyle: const TextStyle(fontSize: 12),
                          backgroundColor: screenBackgroundColor,
                        ))
                  ],
                ),

          // Text(
          //   post.title,
          //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),

          ListTile(
            contentPadding: const EdgeInsets.all(0),
            minVerticalPadding: 0,
            horizontalTitleGap: getProportionateScreenWidth(10),
            dense: true,
            leading: CircleAvatar(
              radius: getProportionateScreenWidth(17),
              backgroundImage:
                  AssetImage(vm.postProfileImgPath), //이미지만 넣으면 에러남(아마도 해결)
            ),
            title: Text(
              vm.postDetail.userNickname,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(
                  vm.postDetail.createdAt,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: postColor),
                ),
                const HorizontalSpacing(of: 15),
                //        Icon(
                //   CupertinoIcons.eye,
                //   size: getProportionateScreenWidth(15),
                //   color: postColor,
                // ),
                // const HorizontalSpacing(of: 5),
                // Text(
                //   vm.postDetail.viewCount,  //아직 서버에서 안넘겨줌
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: postColor,
                //     fontSize: getProportionateScreenWidth(13),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
