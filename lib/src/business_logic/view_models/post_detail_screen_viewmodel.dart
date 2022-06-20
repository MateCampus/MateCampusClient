import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
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
  final ReportService _reportService = serviceLocator<ReportService>();

  PostDetailPresentation _postDetail = defaultPostDetail;
  List<CommentPresentation> _comments = List.empty(growable: true);
  int _currentPostId = -1;
  int _parentId = -1; //대댓글 생성할 때 쓰는용도
  bool _isliked = false;
  bool _isBookMarked = false;
  final String _postProfileImgPath = 'assets/images/user/general_user.png';
  final _commentTextController = TextEditingController();
  final _nestedCommentTextController = TextEditingController();
  final _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  double _currentScrollOffset = 0;
  //double keyboardHeight = 0;
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  ReportType _reportValue = ReportType.report0000;

  String get postProfileImgPath => _postProfileImgPath;
  TextEditingController get commentTextController => _commentTextController;
  TextEditingController get nestedCommentTextController =>
      _nestedCommentTextController;
  FocusNode get focusNode => _focusNode;
  ScrollController get commentScrollController => _scrollController;
  ReportType get reportValue => _reportValue;

  static final PostDetailPresentation
      defaultPostDetail = //postDetailPresentation 초기값 설정
      PostDetailPresentation(
          id: 0,
          loginId: '',
          categories: [],
          title: '',
          userNickname: '',
          imageUrls: [],
          body: '',
          createdAt: '',
          likedCount: '',
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
            body: comment.body,
            deleted: comment.deleted,
            parentId: comment.parentId,
            children: comment.children
                .map((nestedComment) => CommentPresentation(
                    id: nestedComment.id,
                    loginId: nestedComment.loginId,
                    userNickname: nestedComment.userNickname,
                    body: nestedComment.body,
                    deleted: nestedComment.deleted,
                    parentId: nestedComment.parentId,
                    createdAt: dateToTimeEng(
                        nestedComment.createdAt ?? DateTime(2021, 05, 05)),
                    children: nestedComment.children))
                .toList(),
            createdAt:
                dateToTimeEng(comment.createdAt ?? DateTime(2021, 05, 05))))
        .toList();

    _postDetail = PostDetailPresentation(
      id: postDetailResult.id,
      loginId: postDetailResult.loginId,
      categories: postDetailResult.categories == null
          ? defaultPostDetail.categories
          : postDetailResult.categories!
              .map((category) =>
                  CategoryData.iconOf(category.name) +
                  " " +
                  CategoryData.korNameOf(category.name))
              .toList(),
      title: postDetailResult.title,
      userNickname: postDetailResult.userNickname,
      body: postDetailResult.body,
      createdAt: dateToTimeEng(postDetailResult.createdAt),
      likedCount: postDetailResult.likedCount.toString(),
      commentCount: postDetailResult.commentCount.toString(),
      imageUrls: postDetailResult.imageUrls,
    );

    _currentPostId = postId;
  }

  Future<void> changeLikedBookMarked(int postId) async {
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    _isliked = postMainScreenViewModel.likepostIds.contains(postId);
    _isBookMarked = postMainScreenViewModel.bookmarkpostIds.contains(postId);
  }

  void likePost(int postId) async {
    Map<String, int> result = await _postService.likePost(postId: postId);
    _isliked = !_isliked;
    PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();
    isliked
        ? postMainScreenViewModel.likepostIds.add(result["postId"]!)
        : postMainScreenViewModel.likepostIds.remove(result["postId"]!);
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

  void createComment() async {
    if (_commentTextController.text.isEmpty) {
      toastMessage('댓글을 입력해주세요');
      return;
    }
    bool isCreated = await _commentService.createComment(
        postId: _postDetail.id, body: _commentTextController.text);
    if (isCreated) {
      await refreshComments();
      _commentTextController.clear();
      _focusNode.unfocus();
      scrollToEnd();
    } else {
      print('댓글 생성 실패');
    }
  }

  void createNestedComment() async {
    if (_nestedCommentTextController.text.isEmpty) {
      toastMessage('댓글을 입력해주세요');
      return;
    }
    bool isCreated = await _commentService.createNestedComment(
        postId: _postDetail.id,
        parentId: _parentId,
        body: _nestedCommentTextController.text);
    if (isCreated) {
      removeNestedCommentOverlay();
      await refreshComments();
      _nestedCommentTextController.clear();
      _focusNode.unfocus();
      scrollToTargetPosition();
    } else {
      print('대댓글 생성 실패');
    }
  }

  Future<void> refreshComments() async {
    _comments.clear();
    List<Comment> commentsResult =
        await _commentService.fetchComments(postId: _currentPostId);
    _comments.addAll(commentsResult.map((comment) => CommentPresentation(
        id: comment.id,
        loginId: comment.loginId,
        userNickname: comment.userNickname,
        body: comment.body,
        deleted: comment.deleted,
        parentId: comment.parentId,
        children: comment.children
            .map((nestedComment) => CommentPresentation(
                id: nestedComment.id,
                loginId: nestedComment.loginId,
                userNickname: nestedComment.userNickname,
                body: nestedComment.body,
                deleted: nestedComment.deleted,
                parentId: nestedComment.parentId,
                createdAt: dateToPastTime(
                    nestedComment.createdAt ?? DateTime(2021, 05, 05)),
                children: nestedComment.children))
            .toList(),
        createdAt:
            dateToPastTime(comment.createdAt ?? DateTime(2021, 05, 05)))));

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

  void reportPost(BuildContext context, int postId) async {
    bool result =
        await _reportService.reportPost(type: _reportValue, postId: postId);
    if (result) {
      _reportValue = ReportType.report0000;
      Navigator.pop(context);
      toastMessage('신고처리 되었습니다');
    } else {
      Navigator.pop(context);
    }
  }

  void reportComment(BuildContext context, int commentId) async {
    bool result = await _reportService.reportComment(
        type: _reportValue, commentId: commentId);
    if (result) {
      _reportValue = ReportType.report0000;
      Navigator.pop(context);
      toastMessage('신고처리 되었습니다');
    } else {
      Navigator.pop(context);
    }
  }

  void setReportType(ReportType value) {
    _reportValue = value;
    //print(_reportValue);
    notifyListeners();
  }

  void deleteComment(BuildContext context, int commentId) async {
    bool isDeleted = await _commentService.deleteComment(
        postId: _postDetail.id, commentId: commentId);
    if (isDeleted) {
      Navigator.pop(context);
      print('댓글 삭제 성공');
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
      toastMessage("게시물이 삭제되었습니다");
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
      overlayEntry = showNestedCommentInput(parentUserNickname);
      Overlay.of(context)?.insert(overlayEntry!);
      print('createoverlay');
    }
    notifyListeners();
  }

  // 대댓글 overlay 해제
  void removeNestedCommentOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
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
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: const [
                          TextSpan(
                              text: '님에게 댓글을 다는 중',
                              style: TextStyle(
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
  final List<dynamic> categories;
  final String title;
  final String userNickname;
  final String body;
  String createdAt;
  String likedCount;
  String commentCount;
  List<String> imageUrls;

  PostDetailPresentation({
    required this.id,
    required this.loginId,
    required this.categories,
    required this.title,
    required this.userNickname,
    required this.body,
    required this.createdAt,
    required this.likedCount,
    required this.commentCount,
    required this.imageUrls,
  });
}

class CommentPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final String body;
  bool deleted;
  final int parentId;
  String createdAt;
  List<dynamic> children;

  CommentPresentation({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.body,
    required this.deleted,
    required this.parentId,
    required this.createdAt,
    required this.children,
  });
}
