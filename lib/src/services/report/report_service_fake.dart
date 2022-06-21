import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';

class FakeReportService implements ReportService {
  @override
  Future<bool> reportPost({required ReportType type, required int postId}) {
    // TODO: implement reportPost
    throw UnimplementedError();
  }

  @override
  Future<bool> reportComment(
      {required ReportType type, required int commentId}) {
    // TODO: implement reportComment
    throw UnimplementedError();
  }

  @override
  Future<bool> reportUser({required ReportType type, required String loginId}) {
    // TODO: implement reportUser
    throw UnimplementedError();
  }
}
