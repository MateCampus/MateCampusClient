import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';

class ReportViewModel extends BaseModel {
  final ReportService _reportService = serviceLocator<ReportService>();

  final _bodyTextController = TextEditingController();
  TextEditingController get bodyTextController => _bodyTextController;
  final reportFormFocusNode = FocusNode();

  void detectTextController() {
    _bodyTextController.addListener(() {
      notifyListeners();
    });
  }

  void report(
      {required BuildContext context,
      required String targetUserLoginId,
      required String reportCategoryIndex}) async {
    if (_bodyTextController.text.isEmpty) {
      toastMessage('신고 사유를 적어주세요');
      return;
    }
    bool isReported = await _reportService.report(
        targetUserLoginId: targetUserLoginId,
        body: _bodyTextController.text,
        reportCategoryIndex: reportCategoryIndex);
    if (isReported) {
      Navigator.pop(context);
      toastMessage('신고처리 되었습니다');
    } else {
      Navigator.pop(context);
    }
  }
  // ReportType _reportValue = ReportType.report0000;
  // ReportType get reportValue => _reportValue;

  // void setReportType(ReportType value) {
  //   _reportValue = value;
  //   //print(_reportValue);
  //   notifyListeners();
  // }

  // void reportUser(BuildContext context, String loginId) async {
  //   String result =
  //       await _reportService.reportUser(type: _reportValue, loginId: loginId);
  //   if (result == "SUCCESS") {
  //     Navigator.pop(context);
  //     toastMessage('신고처리 되었습니다');
  //   } else if (result == "DUPLICATE") {
  //     Navigator.pop(context);
  //     toastMessage('이미 신고 하셨습니다');
  //   } else {
  //     Navigator.pop(context);
  //   }
  //   _reportValue = ReportType.report0000; // check 표시 안히기 위해서.
  // }

  // void reportPost(BuildContext context, int postId) async {
  //   String result =
  //       await _reportService.reportPost(type: _reportValue, postId: postId);
  //   if (result == "SUCCESS") {
  //     Navigator.pop(context);
  //     toastMessage('신고처리 되었습니다');
  //   } else if (result == "DUPLICATE") {
  //     Navigator.pop(context);
  //     toastMessage('이미 신고 하셨습니다');
  //   } else {
  //     Navigator.pop(context);
  //   }
  //   _reportValue = ReportType.report0000; // check 표시 안히기 위해서.
  // }

  // void reportComment(BuildContext context, int commentId) async {
  //   String result = await _reportService.reportComment(
  //       type: _reportValue, commentId: commentId);
  //   if (result == "SUCCESS") {
  //     Navigator.pop(context);
  //     toastMessage('신고처리 되었습니다');
  //   } else if (result == "DUPLICATE") {
  //     Navigator.pop(context);
  //     toastMessage('이미 신고 하셨습니다');
  //   } else {
  //     Navigator.pop(context);
  //   }
  //   _reportValue = ReportType.report0000;
  // }
}
