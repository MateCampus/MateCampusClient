import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';

class ReportServiceImpl implements ReportService {
  @override
  Future<String> reportPost(
      {required ReportType type, required int postId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var reportJson = jsonEncode({"reportType": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(devServer + "/api/report/post/" + postId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: reportJson);
    if (response.statusCode == 200) {
      print('게시물 신고 성공');
      var res = await jsonDecode(utf8.decode(response.bodyBytes));
      return res["reportStatus"];
    } else {
      print('게시물 신고 실패');
      return "실패";
    }
  }

  @override
  Future<String> reportComment(
      {required ReportType type, required int commentId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var reportJson = jsonEncode({"reportType": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(
            devServer + "/api/report/postComment/" + commentId.toString()),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: reportJson);
    if (response.statusCode == 200) {
      print(reportJson);
      var res = await jsonDecode(utf8.decode(response.bodyBytes));
      return res["reportStatus"];
    } else {
      print('댓글 신고 실패');
      return "실패";
    }
  }

  @override
  Future<String> reportUser(
      {required ReportType type, required String loginId}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var reportJson = jsonEncode({"reportType": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(devServer + "/api/report/user/" + loginId),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: reportJson);
    if (response.statusCode == 200) {
      var res = await jsonDecode(utf8.decode(response.bodyBytes));
      return res["reportStatus"];
    } else {
      print('유저 신고 실패');
      return "실패";
    }
  }
}
