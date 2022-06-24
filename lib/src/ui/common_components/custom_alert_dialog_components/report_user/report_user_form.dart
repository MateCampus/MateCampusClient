import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/report_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_title_text.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_type_list.dart';

class ReportUserForm extends StatefulWidget {
  final String loginId;
  const ReportUserForm({Key? key, required this.loginId}) : super(key: key);

  @override
  _ReportUserFormState createState() => _ReportUserFormState();
}

class _ReportUserFormState extends State<ReportUserForm> {
  ReportViewModel vm = serviceLocator<ReportViewModel>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<ReportViewModel>(
        builder: (context, vm, child) {
          return CupertinoAlertDialog(
            content: Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: SizeConfig.screenHeight! * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [const ReportTileText(), ReportTypeList(vm: vm)],
                  ),
                )),
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
                  vm.reportUser(context, widget.loginId);
                },
                child: const Text('신고'),
                textStyle: TextStyle(
                    fontSize: getProportionateScreenWidth(12),
                    color: Colors.red),
              )
            ],
          );
        },
      ),
    );
  }
}
