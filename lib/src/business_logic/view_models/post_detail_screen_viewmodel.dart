import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';

class PostDetailScreenViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();
  final CommentService _commentService = serviceLocator<CommentService>();

  PostDetailPresentation _postDetail = defaultPostDetail;
  List<CommentPresentation> _comments = List.empty(growable: true);
  int _currentPostId = -1;
  int _parentId = -1; //대댓글 생성할 때 쓰는용도
  bool _isliked = false;
  bool _isBookMarked = false;
  // final String _postProfileImgPath = 'assets/images/user/general_user.png';
  final _commentTextController = TextEditingController();
  final _nestedCommentTextController = TextEditingController();
  final _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  double _currentScrollOffset = 0;
  //double keyboardHeight = 0;
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();

  PostMainScreenViewModel postMainScreenViewModel =
      serviceLocator<PostMainScreenViewModel>();

  // String get postProfileImgPath => _postProfileImgPath;
  TextEditingController get commentTextController => _commentTextController;
  TextEditingController get nestedCommentTextController =>
      _nestedCommentTextController;
  FocusNode get focusNode => _focusNode;
  ScrollController get commentScrollController => _scrollController;

  static final PostDetailPresentation
      defaultPostDetail = //postDetailPresentation 초기값 설정
      PostDetailPresentation(
          id: -1,
          loginId: '',
          userNickname: '',
          categories: [],
          collegeName: '',
          userImageUrl: 'assets/images/user/general_user.png',
          imageUrls: [],
          body: '',
          createdAt: '',
          likedCount: '',
          viewCount: '',
          commentCount: '');

  PostDetailPresentation get postDetail => _postDetail;
  List<CommentPresentation> get comments => _comments;
  bool get isliked => _isliked;
  bool get isBookMarked => _isBookMarked;

  void initData(int postId) async {
    setBusy(true);
    await loadPostDetail(postId);
    await changeLikedBookMarked(postId);
    setBusy(false);
  }

  Future<void> loadPostDetail(int postId) async {
    Post postDetailResult = await _postService.fetchPostDetail(postId: postId);

    _comments = postDetailResult.comments!
        .map((comment) => CommentPresentation(
            id: comment.id,
            loginId: comment.loginId,
            userNickname: comment.userNickname,
            collegeName: CollegeData.korNameOf(describeEnum(
                comment.userCollegeCode ?? CollegeCode.college0000)),
            userImageUrl: comment.userImageUrl.isNotEmpty
                ? comment.userImageUrl
                : 'assets/images/user/general_user.png',
            body: comment.body,
            deleted: comment.deleted,
            parentId: comment.parentId,
            children: comment.children
                    ?.map((nestedComment) => CommentPresentation(
                        id: nestedComment.id,
                        loginId: nestedComment.loginId,
                        userNickname: nestedComment.userNickname,
                        collegeName: CollegeData.korNameOf(describeEnum(
                            nestedComment.userCollegeCode ??
                                CollegeCode.college0000)),
                        userImageUrl: nestedComment.userImageUrl.isNotEmpty
                            ? nestedComment.userImageUrl
                            : 'assets/images/user/general_user.png',
                        body: nestedComment.body,
                        deleted: nestedComment.deleted,
                        parentId: nestedComment.parentId,
                        createdAt:
                            dateToElapsedTime(nestedComment.createdAt ?? DateTime(2021, 05, 05)),
                        children: nestedComment.children ?? []))
                    .toList() ??
                [],
            createdAt: dateToElapsedTime(comment.createdAt ?? DateTime(2021, 05, 05))))
        .toList();

    _postDetail = PostDetailPresentation(
      id: postDetailResult.id,
      loginId: postDetailResult.loginId,
      userNickname: postDetailResult.userNickname,
      categories: postDetailResult.postCategoryCodes
              ?.map<String>(
                  (category) => PostCategoryData.korNameOf(category.name))
              .toList() ??
          [],
      collegeName: CollegeData.korNameOf(describeEnum(
          postDetailResult.userCollegeCode ?? CollegeCode.college0000)),
      userImageUrl: postDetailResult.userImageUrl.isNotEmpty
          ? postDetailResult.userImageUrl
          : defaultPostDetail.userImageUrl,
      body: postDetailResult.body,
      createdAt: dateToElapsedTime(postDetailResult.createdAt),
      likedCount: postDetailResult.likedCount.toString(),
      commentCount: postDetailResult.commentCount.toString(),
      viewCount: postDetailResult.viewCount.toString(),
      imageUrls: postDetailResult.imageUrls,
    );

    _currentPostId = postId;
  }

  Future<void> changeLikedBookMarked(int postId) async {
    _isliked = postMainScreenViewModel.likepostIds.contains(postId);
    _isBookMarked = postMainScreenViewModel.bookmarkpostIds.contains(postId);
  }

  void likePost(int postId) async {
    Map<String, int> result = await _postService.likePost(postId: postId);
    if (postMainScreenViewModel.likepostIds.contains(postId)) {
      postMainScreenViewModel.likepostIds.remove(result["postId"]!);
      _isliked = false;
    } else {
      postMainScreenViewModel.likepostIds.add(result["postId"]!);
      _isliked = true;
    }
    _postDetail.likedCount = result["likeCount"].toString();
    notifyListeners();
  }

  void bookMarkPost(int postId) async {
    int newPostId = await _postService.bookMarkPost(postId: postId);
    _isBookMarked = !_isBookMarked;
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    isBookMarked
        ? postMainScreenViewModel.bookmarkpostIds.add(newPostId)
        : postMainScreenViewModel.bookmarkpostIds.remove(newPostId);
    notifyListeners();
  }

  void createComment(BuildContext context) async {
    if (_commentTextController.text.isEmpty) {
      toastMessage('댓글을 입력해주세요');
      return;
    }
    buildShowDialogForLoading(
        context: context, barrierColor: Colors.transparent);
    bool isCreated = await _commentService.createComment(
        postId: _postDetail.id, body: _commentTextController.text);
    if (isCreated) {
      await refreshComments();
    } else {
      print('댓글 생성 실패');
    }
    _commentTextController.clear();
    // _focusNode.unfocus();
    scrollToEnd();
    Navigator.pop(context);
  }

  void createNestedComment(BuildContext context) async {
    if (_nestedCommentTextController.text.isEmpty) {
      toastMessage('댓글을 입력해주세요');
      return;
    }
    buildShowDialogForLoading(
        context: context, barrierColor: Colors.transparent);
    bool isCreated = await _commentService.createNestedComment(
        postId: _postDetail.id,
        parentId: _parentId,
        body: _nestedCommentTextController.text);
    if (isCreated) {
      removeNestedCommentOverlay();
      await refreshComments();
    } else {
      print('대댓글 생성 실패');
    }
    _nestedCommentTextController.clear();
    // _focusNode.unfocus();
    scrollToTargetPosition();
    Navigator.pop(context);
  }

  Future<void> refreshComments() async {
    _comments.clear();
    List<Comment> commentsResult =
        await _commentService.fetchComments(postId: _currentPostId);
    _comments.addAll(commentsResult.map((comment) => CommentPresentation(
        id: comment.id,
        loginId: comment.loginId,
        userNickname: comment.userNickname,
        collegeName: CollegeData.korNameOf(
            describeEnum(comment.userCollegeCode ?? CollegeCode.college0000)),
        userImageUrl: comment.userImageUrl.isNotEmpty
            ? comment.userImageUrl
            : 'assets/images/user/general_user.png',
        body: comment.body,
        deleted: comment.deleted,
        parentId: comment.parentId,
        children: comment.children
                ?.map((nestedComment) => CommentPresentation(
                    id: nestedComment.id,
                    loginId: nestedComment.loginId,
                    userNickname: nestedComment.userNickname,
                    collegeName: CollegeData.korNameOf(describeEnum(
                        nestedComment.userCollegeCode ??
                            CollegeCode.college0000)),
                    userImageUrl: nestedComment.userImageUrl.isNotEmpty
                        ? nestedComment.userImageUrl
                        : 'assets/images/user/general_user.png',
                    body: nestedComment.body,
                    deleted: nestedComment.deleted,
                    parentId: nestedComment.parentId,
                    createdAt:
                        dateToElapsedTime(nestedComment.createdAt ?? DateTime(2021, 05, 05)),
                    children: nestedComment.children ?? []))
                .toList() ??
            [],
        createdAt: dateToElapsedTime(comment.createdAt ?? DateTime(2021, 05, 05)))));

    //총 댓글 수 카운트
    int _commentCount = 0;
    //총 댓글 수 카운트 -> 삭제한거도 포함
    for (CommentPresentation comment in _comments) {
      _commentCount++;
      _commentCount += comment.children.length;
    }

    _postDetail.commentCount = _commentCount.toString();

    notifyListeners();
  }

  void updatePostMainLiked(){
    postMainScreenViewModel.changeLiked();
  }

  //현재 스크롤 오프셋 가져옴
  void getScrollOffset(double offset) {
    _currentScrollOffset = offset;
  }

  //댓글 달 때 사용
  void scrollToEnd() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  //대댓글 달 때 사용. 대댓글 달려고 하는 부모 comment위치로 이동
  void scrollToTargetPosition() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_currentScrollOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  void deleteComment(BuildContext context, int commentId) async {
    bool isDeleted = await _commentService.deleteComment(commentId: commentId);
    if (isDeleted) {
      Navigator.pop(context);
      toastMessage("댓글이 삭제되었습니다");
      refreshComments();
    } else {
      Navigator.pop(context);
      print('댓글 삭제 오류');
    }
  }

  void deletePost(BuildContext context, int postId) async {
    //bottomSheet내리는 용도의pop
    Navigator.pop(context);
    bool isDeleted = await _postService.deletePost(postId: postId);
    if (isDeleted) {
      toastMessage("피드가 삭제되었습니다");
    } else {
      print('실패');
    }
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    postMainScreenViewModel.refreshPostAfterDelete(postId);
    //postMain으로 돌아가기위한 용도의 pop. pop으로 하지 않으면 postmain이 로드되면서 또 새롭게 서버에서 post를 가져온다
    Navigator.pop(context);
  }

  // 대댓글 overlay 생성
  void createNestedCommentOverlay(
      BuildContext context, String parentUserNickname, int parentId) {
    _parentId = parentId;
    if (overlayEntry == null) {
      _focusNode.requestFocus();
      overlayEntry = showNestedCommentInput(parentUserNickname);
      Overlay.of(context)?.insert(overlayEntry!);
      print('createoverlay');
    }
    notifyListeners();
  }

  // 대댓글 overlay 해제
  void removeNestedCommentOverlay() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    overlayEntry?.remove();
    overlayEntry = null;
    _nestedCommentTextController.clear();
    print('removeoverlay');
    notifyListeners();
  }

  //댓글창 위에 올라오는 overlay 형태 -> 뷰에서 사용하진 않고 createNestedCommentOverlay에서 사용한다
  OverlayEntry showNestedCommentInput(String targetUserNickname) {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: SizeConfig.screenWidth,
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, -getProportionateScreenHeight(40)),
          child: Material(
            child: Container(
                height: getProportionateScreenHeight(40),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25)),
                decoration: const BoxDecoration(
                  color: kMainColor,
                ),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: targetUserNickname,
                            style: TextStyle(
                              fontSize: resizeFont(13),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                          TextSpan(
                              text: ' 님에게 답글 남기는 중',
                              style: TextStyle(
                                  fontSize: resizeFont(12),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300))
                        ])),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        removeNestedCommentOverlay();
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class PostDetailPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final List<String> categories;
  final String collegeName;
  String userImageUrl;
  final String body;
  String createdAt;
  String likedCount;
  String commentCount;
  String viewCount;
  List<String> imageUrls;

  PostDetailPresentation({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.categories,
    required this.collegeName,
    required this.userImageUrl,
    required this.body,
    required this.createdAt,
    required this.likedCount,
    required this.commentCount,
    required this.viewCount,
    required this.imageUrls,
  });
}

class CommentPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final String collegeName;
  String userImageUrl;
  final String body;
  bool deleted;
  final int parentId;
  String createdAt;
  List<dynamic> children;

  CommentPresentation({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.collegeName,
    required this.userImageUrl,
    required this.body,
    required this.deleted,
    required this.parentId,
    required this.createdAt,
    required this.children,
  });
}
