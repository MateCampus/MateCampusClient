import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
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
  int _nextPageToken = 0;
final RegExp bodyRegexp = RegExp(r"\n+");
  PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();

  List<PostPresentation> get myPosts => _myPosts;
  // List<PostPresentation> get myFeedPosts => _myFeedPosts;
  ScrollController get myPostScrollController => _scrollController;
  GlobalKey<RefreshIndicatorState> get myPostMainKey =>
      _myPostRefreshIndicatorKey;

  

  void initData() async {
    // if (isInit) return;
    _nextPageToken =0;
    scrollInit();
    await loadMypagePosts("Feed");
    // await loadMyLikeBookmarkPostIds(); 얘는 나중에 좋아요 로직 정리할때 써야할수도?

    // isInit = true;
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
    if (isFrom == "BookMark") {
      postResult =
          await _postService.fetchBookmarkPosts(nextPageToken: _nextPageToken);
    } else if (isFrom == "Feed") {
      postResult =
          await _postService.fetchMyPosts(nextPageToken: _nextPageToken);
    }
    presentationPosts(postResult);
    setBusy(false);
  }

  Future<void> loadMoreMyPosts() async {

    buildShowDialogForLoading(
        context: _myPostRefreshIndicatorKey.currentContext!,
        barrierColor: Colors.transparent);
    List<Post> additionalPosts =
        await _postService.fetchMyPosts(nextPageToken: _nextPageToken);
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
            collegeName: CollegeData.korNameOf(
                describeEnum(post.userCollegeCode ?? CollegeCode.college0000)),
            userImageUrl: post.userImageUrl.isNotEmpty
                ? post.userImageUrl
                : 'assets/images/user/general_user.png',
            body: post.body.replaceAll(bodyRegexp, " "),
            createdAt: dateToElapsedTime(post.createdAt),
            likedCount: post.likedCount.toString(),
            viewCount: post.viewCount.toString(),
            commentCount: post.commentCount.toString(),
            imageUrls: post.imageUrls,
            isLiked: postMainScreenViewModel.likepostIds.contains(post.id)? true:false
          )));
      _nextPageToken++;
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
                      ?.map<String>((category) =>
                          PostCategoryData.korNameOf(category.name))
                      .toList() ??
                  [],
              collegeName: CollegeData.korNameOf(describeEnum(
                  post.userCollegeCode ?? CollegeCode.college0000)),
              userImageUrl: post.userImageUrl.isNotEmpty
                  ? post.userImageUrl
                  : 'assets/images/user/general_user.png',
              body: post.body.replaceAll(bodyRegexp, " "),
              createdAt: dateToElapsedTime(post.createdAt),
              likedCount: post.likedCount.toString(),
              viewCount: post.viewCount.toString(),
              commentCount: post.commentCount.toString(),
              imageUrls: post.imageUrls,
              isLiked: postMainScreenViewModel.likepostIds.contains(post.id)? true:false
            ))
        .toList();
    _nextPageToken++;
  }

  void likePost(PostPresentation post) async {
    Map<String, int> result = await _postService.likePost(postId: post.id);
    post.isLiked = !post.isLiked;
    post.isLiked
        ? postMainScreenViewModel.likepostIds.add(result["postId"]!)
        : postMainScreenViewModel.likepostIds.remove(result["postId"]!);
    post.likedCount = result["likeCount"].toString();
    notifyListeners();
  }

  Future<void> refreshMyPost() async {
    _myPosts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    loadMypagePosts("Feed");
  }

  void resetData() {
    isInit = false;
    _myPosts = [];
    _nextPageToken = 0;
  }
}
