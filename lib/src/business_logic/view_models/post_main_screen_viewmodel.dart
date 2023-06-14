import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/functionType.dart';
import 'package:zamongcampus/src/business_logic/models/enums/workType.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/statistics/work_history_service.dart';

class PostMainScreenViewModel extends BaseModel {
  bool isInit = false;
  final PostService _postService = serviceLocator<PostService>();
  final WorkHistoryService _workHistoryService =
      serviceLocator<WorkHistoryService>();

  List<PostPresentation> _posts = List.empty(growable: true);
  List<int> likepostIds = [];
  List<int> bookmarkpostIds = [];
  String _sortType = "recent";
  final ScrollController _scrollController = ScrollController();
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
    await loadMyLikeBookmarkPostIds();
    await loadPosts();
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
        oldestPostId: getOldestPostId(),
        collegeFilter: _collegeFilter);
    _posts = postResult
        .map((post) => PostPresentation(
            id: post.id,
            loginId: post.loginId,
            userNickname: post.userNickname,
            categories: post.postCategoryCodes
                    ?.map<String>(
                        (category) => PostCategoryData.korNameOf(category.name))
                    .toList() ??
                [],
            collegeName: post.userCollegeName ?? "",
            userImageUrl: post.userImageUrl.isNotEmpty
                ? post.userImageUrl
                : 'assets/images/user/general_user.png',
            body: post.body.replaceFirst(bodyRegexp, " "),
            createdAt: dateToElapsedTime(post.createdAt),
            likedCount: post.likedCount.toString(),
            viewCount: post.viewCount.toString(),
            commentCount: post.commentCount.toString(),
            imageUrls: post.imageUrls,
            isLiked:
                post.liked ?? likepostIds.contains(post.id) ? true : false))
        .toList();

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
        oldestPostId: getOldestPostId(),
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
          collegeName: post.userCollegeName ?? "",
          userImageUrl: post.userImageUrl.isNotEmpty
              ? post.userImageUrl
              : 'assets/images/user/general_user.png',
          body: post.body.replaceAll(bodyRegexp, " "),
          createdAt: dateToElapsedTime(post.createdAt),
          likedCount: post.likedCount.toString(),
          viewCount: post.viewCount.toString(),
          commentCount: post.commentCount.toString(),
          imageUrls: post.imageUrls,
          isLiked:
              post.liked ?? likepostIds.contains(post.id) ? true : false)));
    }
    Navigator.pop(_postMainRefreshIndicatorKey.currentContext!);
    notifyListeners();
  }

  void likePost(PostPresentation post) async {
    Map<String, int> result = await _postService.likePost(postId: post.id);
    if (likepostIds.contains(post.id)) {
      likepostIds.remove(result["postId"]!);
      post.isLiked = false;
    } else {
      likepostIds.add(result["postId"]!);
      post.isLiked = true;
    }

    post.likedCount = result["likeCount"].toString();
    notifyListeners();
  }

  void updatePost(
      int id, bool isLiked, String likeCount, String? commentCount) {
    for (PostPresentation post in _posts) {
      if (post.id == id) {
        post.isLiked = isLiked;
        post.likedCount = likeCount;
        post.commentCount = commentCount ?? post.commentCount;

        if (!isLiked) {
          likepostIds.remove(id);
        } else {
          if (!likepostIds.contains(id)) {
            likepostIds.add(id);
          }
        }
        break;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //이 함수 쓰는 이유 -> https://velog.io/@jun7332568/플러터flutter-setState-or-markNeedsBuild-called-during-build.-오류-해결 참고
      notifyListeners();
    });
  }

  Future<void> setCollegeFilter() async {
    setBusy(true);
    _posts.clear(); //포스트에 담았던거 다 비움
    _collegeFilter = !_collegeFilter;
    await loadPosts();
    setBusy(false);
  }

  Future<void> refreshPostAfterCreateUpdate() async {
    _posts.clear(); //포스트에 담았던거 다 비움
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
    _posts.clear();
  }

  String getOldestPostId() {
    if (_posts.isNotEmpty) {
      return _posts.last.id.toString();
    } else {
      return "";
    }
  }

  void workHistoryFeedWrite() {
    _workHistoryService.sendWorkHistory(
        workType: WorkType.VISIT, functionType: FunctionType.FEED_WRITE);
  }

  void workHistoryFeedToProfile() {
    _workHistoryService.sendWorkHistory(
        workType: WorkType.VISIT, functionType: FunctionType.FEED_TO_PROFILE);
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
  bool isLiked;

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
      required this.imageUrls,
      required this.isLiked});
}
