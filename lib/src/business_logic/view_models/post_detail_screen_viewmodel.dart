import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';

class PostDetailScreenViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();

  PostDetailPresentation _postDetail = defaultPostDetail;
  final List<CommentPresentation> _comments = [];
  bool _isliked = false;

  static final PostDetailPresentation
      defaultPostDetail = //postDetailPresentation 초기값 설정
      PostDetailPresentation(
          id: 0,
          loginId: '',
          categories: [],
          title: '',
          userNickname: '',
          userImageUrl: 'assets/images/user/general_user.png',
          body: '',
          createdAt: '',
          likedCount: '',
          commentCount: '');

  PostDetailPresentation get postDetail => _postDetail; //요기
  List<CommentPresentation> get comments => _comments;
  bool get isliked => _isliked;

  void loadPostDetail(int postId) async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500)); // 2초 딜레이
    Post postDetailResult = await _postService.fetchPostDetail(postId: postId);

    comments.addAll(postDetailResult.comments?.map((comment) =>
            CommentPresentation(
                id: comment.id,
                loginId: comment.loginId,
                userNickname: comment.userNickname,
                userImageUrl: comment.userImageUrls?.first ??
                    'assets/images/user/general_user.png',
                body: comment.body,
                createdAt: dateToPastTime(comment.createdAt))) ??
        []);

    _postDetail = PostDetailPresentation(
      id: postDetailResult.id,
      loginId: postDetailResult.loginId,
      categories: postDetailResult.categories
          ?.map((category) =>
              CategoryData.iconOf(category.name) +
              " " +
              CategoryData.korNameOf(category.name))
          .toList(),
      title: postDetailResult.title,
      userNickname: postDetailResult.userNickname,
      userImageUrl:
          postDetailResult.userImageUrls?.first ?? _postDetail.userImageUrl,
      body: postDetailResult.body,
      createdAt: dateToPastTime(postDetailResult.createdAt),
      likedCount: postDetailResult.likedCount.toString(),
      commentCount: postDetailResult.comments?.length.toString() ?? '0',
      imageUrls: postDetailResult.imageUrls?.toList(),
    );

    setBusy(false);
  }

  void likePost(String loginId, int postId) async {
    setBusy(true);
    _isliked = !_isliked;
    int likecount =
        await _postService.likePost(loginId: loginId, postId: postId);
    _postDetail.likedCount = likecount.toString();
    setBusy(false);
  }
}

class PostDetailPresentation {
  final int id;
  final String loginId;
  final List<dynamic>? categories;
  final String title;
  final String userNickname;
  final String userImageUrl;
  final String body;
  String createdAt;
  String likedCount;
  String commentCount;
  List<dynamic>? imageUrls;

  PostDetailPresentation({
    required this.id,
    required this.loginId,
    required this.categories,
    required this.title,
    required this.userNickname,
    required this.userImageUrl,
    required this.body,
    required this.createdAt,
    required this.likedCount,
    required this.commentCount,
    this.imageUrls,
  });
}

class CommentPresentation {
  final int id;
  final String loginId;
  final String userNickname;
  final String userImageUrl;
  final String body;
  String createdAt;
  List<CommentPresentation>? nestedComments;

  CommentPresentation({
    required this.id,
    required this.loginId,
    required this.userNickname,
    required this.userImageUrl,
    required this.body,
    required this.createdAt,
    this.nestedComments,
  });
}
