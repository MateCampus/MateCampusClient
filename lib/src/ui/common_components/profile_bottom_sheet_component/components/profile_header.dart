import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';

import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_user/report_user_form.dart';

class ProfileHeader extends StatelessWidget {
  var vm;
  ProfileHeader({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin:
                EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
            height: getProportionateScreenHeight(4),
            width: getProportionateScreenWidth(36),
            decoration: const BoxDecoration(
                color: Color(0xffe2e2e2),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                _removeReportPost(context);
              },
              icon: Icon(
                Icons.more_horiz,
                color: const Color(0xffe2e2e2),
                size: getProportionateScreenWidth(30),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              splashRadius: getProportionateScreenWidth(20),
              constraints: const BoxConstraints(),
            ))
      ],
    );
  }

  _removeReportPost(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      barrierColor: Colors.black54,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(
            '신고하기',
            style: TextStyle(
              fontSize: resizeFont(15.0),
              color: Colors.black87,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ReportUserForm(loginId: vm.profile.loginId);
                });
          },
        ),
      ],
      cancelAction: CancelAction(
          title: Text(
            '취소',
            style: TextStyle(
                fontSize: resizeFont(16.0), fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
