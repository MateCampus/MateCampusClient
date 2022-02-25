import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

class PostMainScreenViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  List<PostPresentation> _posts = [];
  String _sortType = "recent";
  ScrollController scrollController = ScrollController();
  int nextPageToken = 0;

  List<PostPresentation> get posts => _posts;
  String get sortType => _sortType;

  void loadPost() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 2000)); // 2초 딜레이
    List<Post> postResult = await _postService.fetchPosts(
        type: _sortType, nextPageToken: nextPageToken);
    posts.addAll(postResult.map((post) => PostPresentation(
        id: post.id,
        loginId: post.loginId,
        userNickname: post.userNickname,
        body: post.body,
        createdAt: dateToPastTime(post.createdAt),
        likedCount: post.likedCount.toString())));
    nextPageToken++;
    setBusy(false);
  }
}

/* String 값으로 변환된 viewmodel */
class PostPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final String body;
  String createdAt;
  String likedCount;
  List<dynamic>? imageUrls;

  PostPresentation(
      {required this.id,
      required this.loginId,
      required this.userNickname,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      this.imageUrls});
}
