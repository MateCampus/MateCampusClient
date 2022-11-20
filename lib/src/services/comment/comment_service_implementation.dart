import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/comment.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';

class CommentServiceImpl implements CommentService {
  @override
  Future<bool> createComment(
      {required int postId, required String body}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    String commentJson = jsonEncode({
      "body": body,
    });
    final response = await http.post(
        Uri.parse(devServer + "/api/post/" + postId.toString() + "/comment"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: commentJson);
    if (response.statusCode == 201) {
      print("댓글 생성 성공");
      return true;
    } else {
      throw Exception("댓글 생성 오류");
    }
  }

  @override
  Future<bool> createNestedComment(
      {required int postId,
      required int parentId,
      required String body}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    String nestedCommentJson = jsonEncode({"body": body, "parentId": parentId});

    final response = await http.post(
        Uri.parse(devServer + "/api/post/" + postId.toString() + "/comment"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: nestedCommentJson);

    if (response.statusCode == 201) {
      print("대댓글 생성 성공");
      return true;
    } else {
      print("성공? 응 아니야");
      return false;
    }
  }

  @override
  Future<List<Comment>> fetchComments({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/post/" + postId.toString() + '/comment'),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      List<Comment> comments = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Comment>((json) => Comment.fromJson(json))
          .toList();
      return comments;
    } else {
      throw Exception('댓글 가져오기 실패');
    }
  }

  @override
  Future<List<Comment>> fetchMyComments() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(Uri.parse(devServer + "/api/comment/my"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      List<Comment> myComments =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<Comment>((json) => Comment.fromJson(json))
              .toList();
      return myComments;
    } else {
      throw Exception('내 댓글 가져오기 실패');
    }
  }

  @override
  Future<bool> deleteComment({required int commentId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();

    final response = await http.delete(
        Uri.parse(devServer + "/api/comment/" + commentId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 204) {
      print('삭제 완료');
      return true;
    } else {
      print(response.statusCode);
      print('오류: 댓글 삭제 실패');
      return false;
    }
  }
}
