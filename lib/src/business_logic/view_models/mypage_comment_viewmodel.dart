import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';

class MypageCommentViewModel extends BaseModel {
  final CommentService _commentService = serviceLocator<CommentService>();

  Future<void> loadMyComments() async {
    setBusy(true);
    //List<Comment> commentResult = await _commentService.fetchMyComments();
    setBusy(false);
  }
}
