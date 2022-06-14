import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

class PostMainScreenViewModel extends BaseModel {
  bool isInit = false;
  final PostService _postService = serviceLocator<PostService>();

  List<PostPresentation> _posts = List.empty(growable: true);
  List<int> likepostIds = [];
  List<int> bookmarkpostIds = [];
  String _sortType = "popular";
  final ScrollController _scrollController = ScrollController();
  int _nextPageToken = 0;
  bool _collegeFilter = false;

  List<PostPresentation> get posts => _posts;
  String get sortType => _sortType;
  bool get collegeFilter => _collegeFilter;
  ScrollController get postScrollController => _scrollController;

  void initData(BuildContext context) async {
    if (isInit) return;
    scrollInit(context);
    await loadPosts();
    await loadMyLikeBookmarkPostIds();

    isInit = true;
  }

  void scrollInit(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.offset > 0) {
        print("끝 지점 도착");
        loadMorePosts(context);
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
    setBusy(true);
    List<Post> postResult = await _postService.fetchPosts(
        type: _sortType,
        nextPageToken: _nextPageToken,
        collegeFilter: _collegeFilter);
    _posts = postResult
        .map((post) => PostPresentation(
              id: post.id,
              loginId: post.loginId,
              categories: post.categories == null
                  ? []
                  : post.categories!
                      .map((category) =>
                          CategoryData.iconOf(category.name) +
                          " " +
                          CategoryData.korNameOf(category.name))
                      .toList(),
              title: post.title,
              body: post.body,
              createdAt: dateToPastTime(post.createdAt),
              likedCount: post.likedCount.toString(),
              viewCount: post.viewCount.toString(),
              commentCount: post.commentCount.toString(),
              imageUrls: post.imageUrls,
            ))
        .toList();

    _nextPageToken++;

    setBusy(false);
  }

  Future<void> loadMorePosts(BuildContext context) async {
    buildShowDialogForLoading(
        context: context, barrierColor: Colors.transparent);
    List<Post> additionalPosts = await _postService.fetchPosts(
        type: _sortType,
        nextPageToken: _nextPageToken,
        collegeFilter: collegeFilter);
    _posts.addAll(additionalPosts.map((post) => PostPresentation(
          id: post.id,
          loginId: post.loginId,
          categories: post.categories == null
              ? []
              : post.categories!
                  .map((category) =>
                      CategoryData.iconOf(category.name) +
                      " " +
                      CategoryData.korNameOf(category.name))
                  .toList(),
          title: post.title,
          body: post.body,
          createdAt: dateToPastTime(post.createdAt),
          likedCount: post.likedCount.toString(),
          viewCount: post.viewCount.toString(),
          commentCount: post.commentCount.toString(),
          imageUrls: post.imageUrls,
        )));
    _nextPageToken++;
    Navigator.pop(context);
    notifyListeners();
  }

  void changePostType(int value) {
    switch (value) {
      case 0:
        _sortType = "popular";
        break;
      case 1:
        _sortType = "recommend";
        break;
      case 2:
        _sortType = "recent";
        break;
      default:
        break;
    }
  }

  void setCollegeFilter() {
    _posts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    _collegeFilter = !_collegeFilter;
    loadPosts();
  }

  void loadPostsByType(int value) {
    _posts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    changePostType(value);
    loadPosts();
  }

  Future<void> refreshPostAfterCreateUpdate() async {
    _posts.clear(); //포스트에 담았던거 다 비움
    _nextPageToken = 0;
    loadPosts();
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
  final List<dynamic> categories;
  final String title;
  final String body;
  String createdAt;
  String likedCount;
  String viewCount;
  String commentCount;
  List<String> imageUrls;

  PostPresentation(
      {required this.id,
      required this.loginId,
      required this.categories,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.likedCount,
      required this.viewCount,
      required this.commentCount,
      required this.imageUrls});
}
