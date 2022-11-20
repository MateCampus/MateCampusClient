import 'dart:convert';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/dummy/post_dummy.dart';
import 'package:zamongcampus/src/config/dummy/user_dummny.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';

import '../../business_logic/models/post.dart';
import 'post_service.dart';

class FakePostService implements PostService {
  @override
  Future<bool> createPost(
      {required String title,
      required String body,
      List<XFile>? imageFileList,
      required List<String> categoryCodeList}) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> fetchPosts(
      {required String type,
      required int nextPageToken,
      required bool collegeFilter}) async {
    List<Post> list = [];
    list.addAll(postMainTestDummy);

    return list;
  }

  @override
  Future<Post> fetchPostDetail({required int postId}) async {
    Post post;
    post = postMainTestDummy[1];
    return post;
  }

  @override
  Future<Map<String, List<int>>> fetchMyLikeBookmarkPostIds() async {
    Map<String, List<int>> ids = {};
    ids.addAll({
      "myLikePostIds": [1, 3],
      "myBookMarkIds": []
    });
    return ids;
  }

  @override
  Future<List<Post>> fetchBookmarkPosts({required int nextPageToken}) {
    // TODO: implement fetchBookmarkPosts
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> fetchMyPosts({required int nextPageToken}) {
    // TODO: implement fetchMyPosts
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchLikedUsers({required int postId}) async {
    List<User> list = [];
    list.addAll(userDummyLikedPost);

    return list;
  }

  @override
  Future<Map<String, int>> likePost({required int postId}) async {
    Map<String, int> result = {};
    result.addAll({"postId": 1, "likeCount": Random().nextInt(100)});
    return result;
  }

  @override
  Future<int> bookMarkPost({required int postId}) {
    // TODO: implement bookMarkPost
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePost({required int postId}) async {
    // TODO: implement deletePost
    print('삭제 페이크 성공');
    bool val = true;
    return val;
  }

  @override
  Future<List<Post>> fetchUserPosts(
      {required String targetLoginId, required int nextPageToken}) {
    // TODO: implement fetchUserPosts
    throw UnimplementedError();
  }
}
