import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

class PostMainScreenViewModel extends BaseModel {
  bool isInit = false;
  final PostService _postService = serviceLocator<PostService>();

  List<PostPresentation> _posts = List.empty(growable: true);
  List<int> likepostIds = [];
  List<int> bookmarkpostIds = [];
  String _sortType = "recent";
  final ScrollController _scrollController = ScrollController();
  int _nextPageToken = 0;
  bool _collegeFilter = false;
  final _postMainRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<PostPresentation> get posts => _posts;
  String get sortType => _sortType;
  bool get collegeFilter => _collegeFilter;
  ScrollController get postScrollController => _scrollController;
  GlobalKey<RefreshIndicatorState> get postMainKey =>
      _postMainRefreshIndicatorKey;

  final RegExp bodyRegexp = RegExp(r"\n+");

  void initData() async {
    if (isInit) return;
    setBusy(true);
    await loadPosts();
    await loadMyLikeBookmarkPostIds();
    setBusy(false);
    scrollInit();

    isInit = true;
  }

  void scrollInit() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.offset > 0) {
        print("끝 지점 도착");
        loadMorePosts();
      }
    });
  }

  Future<void> loadMyLikeBookmarkPostIds() async {
    Map<String, List<int>> ids =
        await _postService.fetchMyLikeBookmarkPostIds();
    likepostIds = ids["myLikePostIds"]!;
    bookmarkpostIds = ids["myBookMarkIds"]!;
  }

  Future<void> loadPosts() async {
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    await homeViewModel.loadNotificationExist();
    List<Post> postResult = await _postService.fetchPosts(
        type: _sortType,
        nextPageToken: _nextPageToken,
        collegeFilter: _collegeFilter);
    _posts = postResult
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
              body: post.body.replaceFirst(bodyRegexp, "\n...\n"),
              createdAt: dateToElapsedTime(post.createdAt),
              likedCount: post.likedCount.toString(),
              viewCount: post.viewCount.toString(),
              commentCount: post.commentCount.toString(),
              imageUrls: post.imageUrls,
            ))
        .toList();

    _nextPageToken++;
    notifyListeners();
  }

  Future<void> loadMorePosts() async {
    buildShowDialogForLoading(
        context: _postMainRefreshIndicatorKey.currentContext!,
        barrierColor: Colors.transparent);
    HomeViewModel homeViewModel = serviceLocator<HomeViewModel>();
    await homeViewModel.loadNotificationExist();
    List<Post> additionalPosts = await _postService.fetchPosts(
        type: _sortType,
        nextPageToken: _nextPageToken,
        collegeFilter: collegeFilter);
    if (additionalPosts.isEmpty) {
      // toastMessage('피드 끝!');
    } else if (additionalPosts.isNotEmpty) {
      _posts.addAll(additionalPosts.map((post) => PostPresentation(
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
          )));
      _nextPageToken++;
    }
    Navigator.pop(_postMainRefreshIndicatorKey.currentContext!);
    notifyListeners();
  }

  Future<void> setCollegeFilter() async {
    setBusy(true);
    _posts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    _collegeFilter = !_collegeFilter;
    await loadPosts();
    setBusy(false);
  }

  Future<void> refreshPostAfterCreateUpdate() async {
    _posts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    await loadPosts();
  }

  void refreshPostAfterDelete(int postId) {
    for (PostPresentation post in _posts) {
      if (post.id == postId) {
        _posts.remove(post);
        break;
      }
    }
    notifyListeners();
  }

  void resetData() {
    isInit = false;
    _posts = [];
    _nextPageToken = 0;
  }
}

/* String 값으로 변환된 viewmodel */
class PostPresentation {
  final int id;
  final String loginId;
  String userNickname;
  final List<String> categories;
  final String collegeName;
  String userImageUrl;
  final String body;
  String createdAt;
  String likedCount;
  String viewCount;
  String commentCount;
  List<String> imageUrls;

  PostPresentation(
      {required this.id,
      required this.loginId,
      required this.userNickname,
      required this.categories,
      required this.collegeName,
      required this.userImageUrl,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.viewCount,
      required this.commentCount,
      required this.imageUrls});
}
