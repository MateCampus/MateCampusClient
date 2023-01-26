import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class PostService {
  Future<bool> createPost(
      {required String title,
      required String body,
      List<XFile>? imageFileList,
      required List<String> categoryCodeList});

  Future<List<Post>> fetchPosts(
      {required String type,
      required String oldestPostId,
      required bool collegeFilter});

  Future<Post> fetchPostDetail({required int postId});
  Future<Map<String, List<int>>> fetchMyLikeBookmarkPostIds();
  Future<List<Post>> fetchBookmarkPosts({required int nextPageToken});
  Future<List<Post>> fetchMyPosts({required String oldestPostId});
  Future<List<Post>> fetchUserPosts(
      {required String targetLoginId, required String oldestPostId});
  Future<List<User>> fetchLikedUsers({required int postId});
  Future<Map<String, int>> likePost({required int postId});
  Future<int> bookMarkPost({required int postId});
  Future<bool> deletePost({required int postId});
}
