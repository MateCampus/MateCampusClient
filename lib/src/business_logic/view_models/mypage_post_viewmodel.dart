import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import '../utils/post_category_data.dart';

///TODO: 추후에 북마크 기능이 추가된다면 여길 아예 분리해버리는게 나을 수도 있다.
class MypagePostViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();
  final _myPostRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  List<PostPresentation> _myPosts = List.empty(growable: true);
  //List<PostPresentation> _myFeedPosts = List.empty(growable: true);
  bool isInit = false;
  final RegExp bodyRegexp = RegExp(r"\n+");
  PostMainScreenViewModel postMainScreenViewModel =
      serviceLocator<PostMainScreenViewModel>();

  List<PostPresentation> get myPosts => _myPosts;
  // List<PostPresentation> get myFeedPosts => _myFeedPosts;
  ScrollController get myPostScrollController => _scrollController;
  GlobalKey<RefreshIndicatorState> get myPostMainKey =>
      _myPostRefreshIndicatorKey;

  void initData() async {
    if (isInit) return;
    scrollInit();
    await loadMypagePosts("Feed");
    // await loadMyLikeBookmarkPostIds(); 얘는 나중에 좋아요 로직 정리할때 써야할수도?

    isInit = true;
  }

  void scrollInit() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.offset > 0) {
        print("끝 지점 도착");
        loadMoreMyPosts();
      }
    });
  }

  Future<void> loadMypagePosts(String isFrom) async {
    setBusy(true);
    List<Post> postResult = List.empty(growable: true);
    postResult =
        await _postService.fetchMyPosts(oldestPostId: getOldestPostId());

    presentationPosts(postResult);
    setBusy(false);
  }

  Future<void> loadMoreMyPosts() async {
    buildShowDialogForLoading(
        context: _myPostRefreshIndicatorKey.currentContext!,
        barrierColor: Colors.transparent);
    List<Post> additionalPosts =
        await _postService.fetchMyPosts(oldestPostId: getOldestPostId());
    if (additionalPosts.isEmpty) {
      print('더 이상 가져올 피드 없음');
    } else {
      _myPosts.addAll(additionalPosts.map((post) => PostPresentation(
          id: post.id,
          loginId: post.loginId,
          userNickname: post.userNickname,
          categories: post.postCategoryCodes
                  ?.map<String>(
                      (category) => PostCategoryData.korNameOf(category.name))
                  .toList() ??
              [],
          collegeName: post.userCollegeName??"",
          userImageUrl: post.userImageUrl.isNotEmpty
              ? post.userImageUrl
              : 'assets/images/user/general_user.png',
          body: post.body.replaceAll(bodyRegexp, " "),
          createdAt: dateToElapsedTime(post.createdAt),
          likedCount: post.likedCount.toString(),
          viewCount: post.viewCount.toString(),
          commentCount: post.commentCount.toString(),
          imageUrls: post.imageUrls,
          isLiked: post.liked ??
                  postMainScreenViewModel.likepostIds.contains(post.id)
              ? true
              : false)));
    }
    Navigator.pop(_myPostRefreshIndicatorKey.currentContext!);
    notifyListeners();
  }

  void presentationPosts(List<Post> posts) {
    _myPosts = posts
        .map((post) => PostPresentation(
            id: post.id,
            loginId: post.loginId,
            userNickname: post.userNickname,
            categories: post.postCategoryCodes
                    ?.map<String>(
                        (category) => PostCategoryData.korNameOf(category.name))
                    .toList() ??
                [],
            collegeName: post.userCollegeName??"",
            userImageUrl: post.userImageUrl.isNotEmpty
                ? post.userImageUrl
                : 'assets/images/user/general_user.png',
            body: post.body.replaceAll(bodyRegexp, " "),
            createdAt: dateToElapsedTime(post.createdAt),
            likedCount: post.likedCount.toString(),
            viewCount: post.viewCount.toString(),
            commentCount: post.commentCount.toString(),
            imageUrls: post.imageUrls,
            isLiked: post.liked ??
                    postMainScreenViewModel.likepostIds.contains(post.id)
                ? true
                : false))
        .toList();
  }

  void likePost(PostPresentation post) async {
    Map<String, int> result = await _postService.likePost(postId: post.id);
    post.isLiked = !post.isLiked;
    post.likedCount = result["likeCount"].toString();
    postMainScreenViewModel.updatePost(
        post.id, post.isLiked, post.likedCount, null);
    notifyListeners();
  }

  Future<void> refreshMyPost() async {
    _myPosts.clear(); //포스트에 담았던거 다 비움
    loadMypagePosts("Feed");
  }

  void resetData() {
    isInit = false;
    _myPosts = [];
  }

  String getOldestPostId() {
    if (_myPosts.isNotEmpty) {
      return _myPosts.last.id.toString();
    } else {
      return "";
    }
  }

  void updatePost(
      int id, bool isLiked, String likeCount, String? commentCount) {
    for (PostPresentation post in _myPosts) {
      if (post.id == id) {
        post.isLiked = isLiked;
        post.likedCount = likeCount;
        post.commentCount = commentCount ?? post.commentCount;

        break;
      }
    }
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //이 함수 쓰는 이유 -> https://velog.io/@jun7332568/플러터flutter-setState-or-markNeedsBuild-called-during-build.-오류-해결 참고
      notifyListeners();
    });
  }
}
