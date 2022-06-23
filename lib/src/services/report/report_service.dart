import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';

abstract class ReportService {
  Future<String> reportPost({required ReportType type, required int postId});
  Future<String> reportComment(
      {required ReportType type, required int commentId});
  Future<String> reportUser(
      {required ReportType type, required String loginId});
}
