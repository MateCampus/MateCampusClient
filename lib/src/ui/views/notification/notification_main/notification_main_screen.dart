import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/notification_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/center_sentence.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/components/body.dart';

class NotificationMainScreen extends StatefulWidget {
  const NotificationMainScreen({Key? key}) : super(key: key);

  @override
  _NotificationMainScreenState createState() => _NotificationMainScreenState();
}

class _NotificationMainScreenState extends State<NotificationMainScreen> {
  NotificationViewModel vm = serviceLocator<NotificationViewModel>();

  @override
  void initState() {
    vm.loadNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<NotificationViewModel>.value(
      value: vm,
      child: Consumer<NotificationViewModel>(builder: (context, vm, child) {
        return Scaffold(
            appBar: SubAppbar(
              titleText: '알림',
              //새로운 알림 추가하는 버튼 임시로 놔둠
              actions: [
                TextButton(
                    onPressed: () {
                      vm.insertItem();
                    },
                    child: const Text(
                      "새로운 알림 추가",
                      style: TextStyle(color: kMainColor),
                    ))
              ],
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: SafeArea(
              child: vm.busy
                  ? const IsLoading()
                  : vm.notifications.isEmpty
                      ? const CenterSentence(
                          sentence: '알림이 존재하지 않습니다',
                          bottomSpace: 100,
                        )
                      : Body(vm: vm),
            ));
      }),
    );
  }
}
