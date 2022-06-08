import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import '../../business_logic/models/post.dart';
import 'post_service.dart';

class FakePostService implements PostService {
  @override
  Future<List<Post>> fetchPosts(
      {required String type, required int nextPageToken}) async {
    List<Post> list = [];
    list.addAll(postDummy1);

    return list;
  }

  @override
  Future<Post> fetchPostDetail({required int postId}) async {
    Post post;
    post = postDummy1[1];
    return post;
  }

  @override
  Future<Map<String, int>> likePost({required int postId}) async {
    Map<String, int> result = {};
    result.addAll({"postId": 1, "likeCount": Random().nextInt(100)});
    return result;
  }

  @override
  Future<bool> createPost(
      {required String title,
      required String body,
      List<XFile>? imageFileList}) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<int>>> fetchMyLikeBookmarkPostIds() {
    // TODO: implement fetchMyLikeBookmarkPostIds
    throw UnimplementedError();
  }

  @override
  Future<int> bookMarkPost({required int postId}) {
    // TODO: implement bookMarkPost
    throw UnimplementedError();
  }
}
