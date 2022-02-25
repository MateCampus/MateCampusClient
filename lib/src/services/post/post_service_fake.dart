import '../../business_logic/models/post.dart';
import 'post_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FakePostService implements PostService {
  @override
  Future<List<Post>> fetchPosts(
      {required String type, required int nextPageToken}) async {
    List<Post> list = [];
    list.add(Post(
        id: 1,
        loginId: "sye",
        userNickname: "폼포코팡팡",
        body: "새로운 맛집이야~",
        createdAt: DateTime(2022, 2, 3),
        likedCount: 73,
        imageUrls: null));
    list.add(Post(
        id: 2,
        loginId: "zamong",
        userNickname: "자몽맛있어~",
        body: "여기는 자몽 맛집이야 진짜 맛있어",
        createdAt: DateTime(2022, 2, 13),
        likedCount: 53,
        imageUrls: null));
    list.add(Post(
        id: 3,
        loginId: "suss",
        userNickname: "미완성작품",
        body: "이상형 찾았어요~ 진짜 대박",
        createdAt: DateTime(2022, 1, 31),
        likedCount: 810,
        imageUrls: null));
    return list;
  }
}
