import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';

class ReportServiceImpl implements ReportService {
  @override
  Future<bool> reportPost(
      {required ReportType type, required int postId}) async {
    var reportJson =
        jsonEncode({"id": postId, "type": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(devServer + "/api/report/post/" + postId.toString()),
        headers: AuthService.get_auth_header(),
        body: reportJson);
    if (response.statusCode == 200) {
      print('게시물 신고 성공');
      return true;
    } else {
      print('게시물 신고 실패');
      return false;
    }
  }

  @override
  Future<bool> reportComment(
      {required ReportType type, required int commentId}) async {
    var reportJson =
        jsonEncode({"id": commentId, "type": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(
            devServer + "/api/report/postComment/" + commentId.toString()),
        headers: AuthService.get_auth_header(),
        body: reportJson);
    if (response.statusCode == 200) {
      print(reportJson);
      print('댓글 신고 성공');
      return true;
    } else {
      print('댓글 신고 실패');
      return false;
    }
  }

  @override
  Future<bool> reportUser(
      {required ReportType type, required String loginId}) async {
    var reportJson =
        jsonEncode({"loginId": loginId, "type": type.name.toUpperCase()});

    final response = await http.post(
        Uri.parse(devServer + "/api/report/user/" + loginId),
        headers: AuthService.get_auth_header(),
        body: reportJson);
    if (response.statusCode == 200) {
      print(reportJson);
      print('유저 신고 성공');
      return true;
    } else {
      print('유저 신고 실패');
      return false;
    }
  }
}
