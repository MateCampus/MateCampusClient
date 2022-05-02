import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';

import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';

class PostListTile extends StatelessWidget {
  final PostPresentation post;
  const PostListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PostDetailScreen.routeName,
            arguments: PostDetailScreenArgs(post.id));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.shade100,
        elevation: 4.0,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                //카테고리 나열 -> viewmodel에서 Row로 정렬되게끔 바꾸기
                children: [
                  ...post.categories.map((category) => Text(
                        category + "  ",
                        style: const TextStyle(fontSize: 12),
                      ))
                ],
              ),
              const VerticalSpacing(of: 10),
              post.imageUrl == null ? _noImg() : _hasImg(),
              const VerticalSpacing(of: 10),
              Row(
                children: [
                  Text(
                    "좋아요 " + post.likedCount,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  const HorizontalSpacing(of: 10),
                  Text(
                    "조회수 " + post.viewCount,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  const HorizontalSpacing(of: 10),
                  Text(
                    "댓글 " + post.commentCount,
                    style: const TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hasImg() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(245),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const VerticalSpacing(
                  of: 5,
                ),
                Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xff818181)),

                  // truncate(post.body, 53,
                  //     omission: "...", position: TruncatePosition.end),
                  // style:
                  //     const TextStyle(fontSize: 13, color: Color(0xff818181)),
                )
              ]),
        ),
        const HorizontalSpacing(of: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: post.imageUrl!.startsWith('https')
              ? CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: post.imageUrl!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : Image.asset(
                  post.imageUrl!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
        )
      ],
    );
  }

  Widget _noImg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const VerticalSpacing(
          of: 5,
        ),
        Text(
          post.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, color: Color(0xff818181)),

          // truncate(post.body, 68,
          //     omission: "...", position: TruncatePosition.end),
          // style: const TextStyle(fontSize: 13, color: Color(0xff818181)),
        )
      ],
    );
  }
}
