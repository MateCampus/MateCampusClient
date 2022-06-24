import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';

class MypageCommentViewModel extends BaseModel {
  final CommentService _commentService = serviceLocator<CommentService>();
  List<CommentPresentation> _comments = List.empty(growable: true);

  List<CommentPresentation> get comments => _comments;

  Future<void> loadMyComments() async {
    setBusy(true);

    List<Comment> commentResult = await _commentService.fetchMyComments();
    //테스트용
    // List<Comment> commentResult =
    //     await _commentService.fetchComments(postId: 1);
    presentationComments(commentResult);
    setBusy(false);
  }

  void presentationComments(List<Comment> comments) {
    _comments = comments
        .map((comment) => CommentPresentation(
            id: comment.id,
            parentId: comment.parentId,
            loginId: comment.loginId,
            userNickname: comment.userNickname,
            body: comment.body,
            createdAt: dateToElapsedTime(comment.createdAt!),
            children: [],
            deleted: comment.deleted))
        .toList();
  }
}
