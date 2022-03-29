import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';

class PostDetailScreenVeiwModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  List<PostDetailPresentation> _postDetail = [];
  List<CommentPresentation> _comments = [];

  int _postId = 0;

  List<PostDetailPresentation> get postDetail => _postDetail;
  List<CommentPresentation> get comments => _comments;

  void loadPostDetail() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 2000)); // 2초 딜레이
    Post postDetailResult = await _postService.fetchPostDetail(postId: _postId);
    postDetail.add(PostDetailPresentation(
        id: postDetailResult.id,
        loginId: postDetailResult.loginId,
        categories: postDetailResult.categories
          ..map((category) =>
              CategoryData.iconOf(category.name) +
              " " +
              CategoryData.korNameOf(category.name)).toList(),
        title: postDetailResult.title,
        userNickname: postDetailResult.userNickname,
        userImageUrls: postDetailResult.userImageUrls.toList(),
        body: postDetailResult.body,
        createdAt: dateToPastTime(postDetailResult.createdAt),
        likedCount: postDetailResult.likedCount.toString(),
        commentCount: postDetailResult.commentCount.toString(),
        imageUrls: postDetailResult.imageUrls?.toList(),
        comments: postDetailResult.comments //여기가 이상함

        ));

    setBusy(false);
  }
}

class PostDetailPresentation {
  final int id;
  final String loginId;
  final List<dynamic> categories;
  final String title;
  final String userNickname;
  final List<String> userImageUrls;
  final String body;
  String createdAt;
  String likedCount;
  String commentCount;
  List<String>? imageUrls;
  List<Comment>? comments;

  PostDetailPresentation(
      {required this.id,
      required this.loginId,
      required this.categories,
      required this.title,
      required this.userNickname,
      required this.userImageUrls,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.commentCount,
      this.imageUrls,
      this.comments});
}

class CommentPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final List<String> userImageUrls;
  final String body;
  String createdAt;
  List<Comment>? nestedComments;

  CommentPresentation({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.userImageUrls,
    required this.body,
    required this.createdAt,
    this.nestedComments,
  });
}
