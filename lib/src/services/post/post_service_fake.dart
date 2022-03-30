import 'dart:math';

import 'package:flutter/material.dart';
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
    post = postDummy1.first;

    return post;
  }
}
