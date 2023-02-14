import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

class PostLikedListViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  List<PostLikedUserPresentation> _likedUsers = List.empty(growable: true);

  List<PostLikedUserPresentation> get likedUsers => _likedUsers;

  void initData(int postId) async {
    setBusy(true);
    await loadPostLikedUsers(postId);
    setBusy(false);
  }

  Future<void> loadPostLikedUsers(int postId) async {
    List<User> likedUserListResult =
        await _postService.fetchLikedUsers(postId: postId);
    _likedUsers = likedUserListResult
        .map((likedUser) => PostLikedUserPresentation(
            loginId: likedUser.loginId,
            nickname: likedUser.nickname,
            collegeName: likedUser.collegeName??"",
            majorName: likedUser.majorName ?? "",
            profileImageUrl: likedUser.imageUrl!.isEmpty
                ? "assets/images/user/general_user.png"
                : likedUser.imageUrl ?? "assets/images/user/general_user.png"))
        .toList();
  }
}

//프리젠테이션 밑에 만들기
class PostLikedUserPresentation {
  final String loginId;
  String nickname;
  final String collegeName;
  final String majorName;
  String profileImageUrl;

  PostLikedUserPresentation(
      {required this.loginId,
      required this.nickname,
      required this.collegeName,
      required this.majorName,
      required this.profileImageUrl});
}
