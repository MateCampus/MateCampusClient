import '../../business_logic/models/post.dart';

abstract class PostService {
  Future<List<Post>> fetchPosts(
      {required String type, required int nextPageToken});
}
