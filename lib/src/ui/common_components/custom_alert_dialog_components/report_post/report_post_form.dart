import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/utils/report_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class ReportPostForm extends StatefulWidget {
  final PostDetailScreenViewModel vm;
  const ReportPostForm({Key? key, required this.vm}) : super(key: key);

  @override
  _ReportPostFormState createState() => _ReportPostFormState();
}

class _ReportPostFormState extends State<ReportPostForm> {
  ReportType _postReport = ReportType.report0000;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: widget.vm,
      child: Consumer<PostDetailScreenViewModel>(
        builder: (context, vm, child) {
          return Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0001.name)),
                    value: ReportType.report0001,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0002.name)),
                    value: ReportType.report0002,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0003.name)),
                    value: ReportType.report0003,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0004.name)),
                    value: ReportType.report0004,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0005.name)),
                    value: ReportType.report0005,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
                RadioListTile(
                    title: Text(
                        ReportTypeData.korNameOf(ReportType.report0006.name)),
                    value: ReportType.report0006,
                    groupValue: _postReport,
                    onChanged: (ReportType? value) {
                      setState(() {
                        _postReport = value!;
                      });
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
