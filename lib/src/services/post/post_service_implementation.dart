import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

import 'post_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostServiceImpl implements PostService {
  @override
  Future<bool> createPost(
      {required String title,
      required String body,
      List<XFile>? imageFileList,
      required List<String> categoryCodeList}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var request =
        http.MultipartRequest("POST", Uri.parse(devServer + "/api/post"))
          ..headers.addAll(AuthService.get_auth_header(
              accessToken: accessToken, refreshToken: refreshToken));
    request.fields['body'] = body;
    request.fields['title'] = title;
    if (imageFileList != null) {
      for (var imageFile in imageFileList) {
        request.files
            .add(await http.MultipartFile.fromPath('files', imageFile.path));
      }
    }
    String categoryCodesJson = categoryCodeList.join(' ,');
    request.fields["categoryCodeList"] = categoryCodesJson;

    var response = await request.send();
    if (response.statusCode == 200) {
      print("post 생성 성공");
      return true;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return createPost(
          title: title, body: body, categoryCodeList: categoryCodeList);
    } else {
      return false;
    }
  }

  @override
  Future<List<Post>> fetchPosts(
      {required String type,
      required int nextPageToken,
      required bool collegeFilter}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();

    final response = await http.get(
        Uri.parse(
          devServer +
              "/api/post/" +
              type +
              "?nextPageToken=" +
              nextPageToken.toString() +
              "&onlyOurCollege=" +
              collegeFilter.toString(),
        ),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<Post> posts = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Post>((json) => Post.fromJson(json))
          .toList();
      return posts;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchPosts(
          type: type,
          nextPageToken: nextPageToken,
          collegeFilter: collegeFilter);
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception(
          '[오류]게시물을 가져오는데 실패했습니다. (Failed to load posts)'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<Post> fetchPostDetail({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/post/" + postId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      Post post =
          Post.fromJson(await jsonDecode(utf8.decode(response.bodyBytes)));
      return post;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchPostDetail(postId: postId);
    } else {
      throw Exception('게시물 패치 오류');
    }
  }

  @override
  Future<Map<String, List<int>>> fetchMyLikeBookmarkPostIds() async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/post/myLikeBookMarkIds"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      var json = await jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, List<int>> ids = {};
      ids.addAll({
        "myLikePostIds": json["myLikePostIds"].cast<int>(),
        "myBookMarkIds": json["myBookMarkIds"].cast<int>()
      });
      return ids;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchMyLikeBookmarkPostIds();
    } else {
      throw Exception('게시물 좋아요, 북마크 Ids 가져오기 오류');
    }
  }

  @override
  Future<List<Post>> fetchBookmarkPosts({required int nextPageToken}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer +
            "/api/post/bookmark?nextPageToken=" +
            nextPageToken.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<Post> bookmarkPosts =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<Post>((json) => Post.fromJson(json))
              .toList();
      return bookmarkPosts;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchBookmarkPosts(nextPageToken: nextPageToken);
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception(
          '북마크한 게시물 가져오기 실패'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<List<Post>> fetchMyPosts({required int nextPageToken}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer +
            "/api/post/my?nextPageToken=" +
            nextPageToken.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<Post> myPosts = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Post>((json) => Post.fromJson(json))
          .toList();
      return myPosts;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchMyPosts(nextPageToken: nextPageToken);
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('내 피드 가져오기 실패'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<List<Post>> fetchUserPosts(
      {required String targetLoginId, required int nextPageToken}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer +
            "/api/post/?userId=" +
            targetLoginId.toString() +
            "&nextPageToken=" +
            nextPageToken.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<Post> posts = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Post>((json) => Post.fromJson(json))
          .toList();
      return posts;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchUserPosts(
          targetLoginId: targetLoginId, nextPageToken: nextPageToken);
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception(
          '상대방 피드 가져오기 실패'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<List<User>> fetchLikedUsers({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.get(
        Uri.parse(devServer + "/api/post/like/" + postId.toString() + "/users"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      List<User> likedUsers = await jsonDecode(utf8.decode(response.bodyBytes))
          .map<User>((json) => User.fromJson(json))
          .toList();
      return likedUsers;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchLikedUsers(postId: postId);
    } else {
      throw Exception('좋아요 유저 리스트 서버에서 가져오기 실패');
    }
  }

  @override
  Future<Map<String, int>> likePost({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.post(
        Uri.parse(devServer + "/api/post/like/" + postId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      var json = await jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, int> result = {};
      result.addAll({"postId": json["postId"], "likeCount": json["likeCount"]});
      return result;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return likePost(postId: postId);
    } else {
      throw Exception('게시물 좋아요 오류');
    }
  }

  @override
  Future<int> bookMarkPost({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.post(
        Uri.parse(devServer + "/api/post/bookmark/" + postId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 200) {
      var postId = await jsonDecode(utf8.decode(response.bodyBytes));
      return postId;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return bookMarkPost(postId: postId);
    } else {
      throw Exception('게시물 좋아요 오류');
    }
  }

  @override
  Future<bool> deletePost({required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await http.delete(
        Uri.parse(devServer + "/api/post/" + postId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));

    if (response.statusCode == 204) {
      print('게시물 삭제 완료');
      return true;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return deletePost(postId: postId);
    } else {
      print('오류: 게시물 삭제 실패');
      return false;
    }
  }
}
