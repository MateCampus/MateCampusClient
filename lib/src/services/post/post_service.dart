import 'package:zamongcampus/src/business_logic/models/post.dart';

abstract class PostService {
  Future<List<Post>> fetchPosts(
      {required String type, required int nextPageToken});

  Future<Post> fetchPostDetail({required int postId});

  Future<int> likePost({required String loginId, required int postId});
}
