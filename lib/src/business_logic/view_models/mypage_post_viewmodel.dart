import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';

import '../utils/post_category_data.dart';

class MypagePostViewModel extends BaseModel {
  final PostService _postService = serviceLocator<PostService>();
  List<PostPresentation> _posts = List.empty(growable: true);
  //List<PostPresentation> _myFeedPosts = List.empty(growable: true);

  List<PostPresentation> get posts => _posts;
  // List<PostPresentation> get myFeedPosts => _myFeedPosts;

  Future<void> loadMypagePosts(String isFrom) async {
    setBusy(true);
    List<Post> postResult = List.empty(growable: true);
    if (isFrom == "BookMark") {
      postResult = await _postService.fetchBookmarkPosts();
    } else if (isFrom == "Feed") {
      postResult = await _postService.fetchMyPosts();
    }
    presentationPosts(postResult);
    setBusy(false);
  }

  void presentationPosts(List<Post> posts) {
    _posts = posts
        .map((post) => PostPresentation(
              id: post.id,
              loginId: post.loginId,
              categories: post.postCategoryCodes
                      ?.map<String>((category) =>
                          PostCategoryData.iconOf(category.name) +
                          " " +
                          PostCategoryData.korNameOf(category.name))
                      .toList() ??
                  [],
              title: post.title,
              body: post.body,
              createdAt: dateToElapsedTime(post.createdAt),
              likedCount: post.likedCount.toString(),
              viewCount: post.viewCount.toString(),
              commentCount: post.commentCount.toString(),
              imageUrls: post.imageUrls,
            ))
        .toList();
  }
}
