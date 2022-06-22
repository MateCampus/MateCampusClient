import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/business_logic/utils/report_data.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ReportTypeListTile extends StatelessWidget {
  final dynamic vm;
  final ReportType type;
  const ReportTypeListTile({Key? key, required this.vm, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(
        ReportTypeData.korNameOf(type.name),
        style: TextStyle(fontSize: resizeFont(13), fontWeight: FontWeight.w500),
      ),
      value: type,
      groupValue: vm.reportValue as ReportType,
      onChanged: (ReportType? value) {
        vm.setReportType(value!);
      },
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
