import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/report_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_text_input.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_title_text.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class ReportForm extends StatefulWidget {
  String targetUserLoginId;
  String reportCategoryIndex;
  ReportForm(
      {Key? key,
      required this.targetUserLoginId,
      required this.reportCategoryIndex})
      : super(key: key);

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  ReportViewModel vm = serviceLocator<ReportViewModel>();

  @override
  void initState() {
    vm.detectTextController();
    super.initState();
  }

  @override
  void dispose() {
    serviceLocator.resetLazySingleton<ReportViewModel>(instance: vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<ReportViewModel>(
        builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: Material(
              color: Colors.transparent,
              child: CupertinoAlertDialog(
                content: SizedBox(
                  height: getProportionateScreenHeight(300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\u{1F6A8}신고하기',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: kTitleFontSize,
                        ),
                      ),
                      VerticalSpacing(),
                      ReportTextInput(vm: vm)
                    ],
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                    textStyle: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      vm.report(
                          context: context,
                          targetUserLoginId: widget.targetUserLoginId,
                          reportCategoryIndex: widget.reportCategoryIndex);
                      // vm.reportUser(context, widget.loginId);
                    },
                    child: const Text('신고'),
                    textStyle: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: Colors.red),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
