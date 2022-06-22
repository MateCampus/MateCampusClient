import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';

abstract class ReportService {
  Future<bool> reportPost({required ReportType type, required int postId});
  Future<bool> reportComment(
      {required ReportType type, required int commentId});
  Future<bool> reportUser({required ReportType type, required String loginId});
}
