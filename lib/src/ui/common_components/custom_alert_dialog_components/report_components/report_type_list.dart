import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/reportType.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_type_list_tile.dart';

class ReportTypeList extends StatelessWidget {
  final dynamic vm;
  const ReportTypeList({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: ReportType.values.length - 1,
        itemBuilder: (context, index) =>
            ReportTypeListTile(vm: vm, type: ReportType.values[index + 1]));
  }
}
