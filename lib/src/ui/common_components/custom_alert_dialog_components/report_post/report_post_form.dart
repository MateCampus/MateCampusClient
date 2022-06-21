import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_title_text.dart';
import 'package:zamongcampus/src/ui/common_components/custom_alert_dialog_components/report_components/report_type_list.dart';

class ReportPostForm extends StatefulWidget {
  final PostDetailScreenViewModel vm;
  const ReportPostForm({Key? key, required this.vm}) : super(key: key);

  @override
  _ReportPostFormState createState() => _ReportPostFormState();
}

class _ReportPostFormState extends State<ReportPostForm> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: widget.vm,
      child: Consumer<PostDetailScreenViewModel>(
        builder: (context, vm, child) {
          return Material(
              color: Colors.transparent,
              child: SizedBox(
                height: SizeConfig.screenHeight! * 0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [const ReportTileText(), ReportTypeList(vm: vm)],
                ),
              ));
        },
      ),
    );
  }
}
