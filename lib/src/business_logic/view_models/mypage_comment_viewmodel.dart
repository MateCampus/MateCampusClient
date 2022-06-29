import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/post_detail_screen_args.dart';
import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';
import 'package:zamongcampus/src/ui/views/post/post_detail/post_detail_screen.dart';

class MypageCommentViewModel extends BaseModel {
  final CommentService _commentService = serviceLocator<CommentService>();
  List<MyCommentPresentation> _comments = List.empty(growable: true);

  List<MyCommentPresentation> get comments => _comments;

  Future<void> loadMyComments() async {
    setBusy(true);

    List<Comment> commentResult = await _commentService.fetchMyComments();
    presentationComments(commentResult);
    setBusy(false);
  }

  void presentationComments(List<Comment> comments) {
    _comments = comments
        .map((comment) => MyCommentPresentation(
              id: comment.id,
              postId: comment.postId!,
              loginId: comment.loginId,
              body: comment.body,
              createdAt: dateToElapsedTime(comment.createdAt!),
            ))
        .toList();
  }

  void deleteMyComment(
      BuildContext context, MyCommentPresentation comment) async {
    bool isDeleted = await _commentService.deleteComment(commentId: comment.id);
    if (isDeleted) {
      Navigator.pop(context);
      _comments.remove(comment);
      print('댓글 삭제 성공');
    } else {
      Navigator.pop(context);
      print('댓글 삭제 오류');
    }

    notifyListeners();
  }

  void gotoPost(BuildContext context, int postId) {
    Navigator.pushNamed(context, PostDetailScreen.routeName,
        arguments: PostDetailScreenArgs(postId));
  }
}

class MyCommentPresentation {
  final int id;
  final int postId;
  final String loginId;
  final String body;
  String createdAt;

  MyCommentPresentation({
    required this.id,
    required this.postId,
    required this.loginId,
    required this.body,
    required this.createdAt,
  });
}
