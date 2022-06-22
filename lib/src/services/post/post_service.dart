import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';

abstract class PostService {
  Future<bool> createPost(
      {required String title,
      required String body,
      List<XFile>? imageFileList,
      required List<String> categoryCodeList});

  Future<List<Post>> fetchPosts(
      {required String type,
      required int nextPageToken,
      required bool collegeFilter});

  Future<Post> fetchPostDetail({required int postId});
  Future<Map<String, List<int>>> fetchMyLikeBookmarkPostIds();
  Future<List<Post>> fetchBookmarkPosts();
  Future<List<Post>> fetchMyPosts();
  Future<Map<String, int>> likePost({required int postId});
  Future<int> bookMarkPost({required int postId});
  Future<bool> deletePost({required int postId});
}
