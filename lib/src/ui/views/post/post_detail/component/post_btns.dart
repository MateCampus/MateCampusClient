import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class PostBtns extends StatefulWidget {
  final PostDetailScreenViewModel vm;
  const PostBtns({Key? key, required this.vm}) : super(key: key);

  @override
  _PostBtnsState createState() => _PostBtnsState();
}

class _PostBtnsState extends State<PostBtns> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () {
              widget.vm.likePost(widget.vm.postDetail.id);
            },
            icon: widget.vm.isliked
                ? Icon(
                    CupertinoIcons.heart_fill,
                    size: getProportionateScreenWidth(20),
                    color: kMainColor,
                  )
                : Icon(
                    CupertinoIcons.heart,
                    size: getProportionateScreenWidth(20),
                    color: Colors.black,
                  ),
            label: Text(
              widget.vm.postDetail.likedCount,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          TextButton.icon(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.bubble_left,
              size: getProportionateScreenWidth(20),
              color: Colors.black,
            ),
            label: Text(
              widget.vm.postDetail.commentCount,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              widget.vm.bookMarkPost(widget.vm.postDetail.id);
            },
            icon: widget.vm.isBookMarked
                ? Icon(
                    CupertinoIcons.bookmark_fill,
                    size: getProportionateScreenWidth(20),
                    color: Colors.orangeAccent,
                  )
                : Icon(
                    CupertinoIcons.bookmark,
                    size: getProportionateScreenWidth(20),
                    color: Colors.black,
                  ),
          ),
        ],
      ),
    );
  }
}
