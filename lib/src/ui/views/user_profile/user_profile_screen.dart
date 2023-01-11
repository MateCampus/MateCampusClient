import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/body.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/chat_btn.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = "/userProfile";
  final String loginId;
  final bool hasBottomBtn;

  const UserProfileScreen(
      {Key? key, required this.loginId, required this.hasBottomBtn})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserProfileDemandSurveyViewModel vm =
      serviceLocator<UserProfileDemandSurveyViewModel>();

  @override
  void initState() {
    vm.initData(widget.loginId);
    super.initState();
  }

  @override
  void dispose() {
    serviceLocator.resetLazySingleton<UserProfileDemandSurveyViewModel>(
        instance: vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<UserProfileDemandSurveyViewModel>(
          builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: kMainScreenBackgroundColor,
            elevation: 0,
          ),
          backgroundColor: kMainScreenBackgroundColor,
          body: vm.busy
              ? const IsLoading()
              : SafeArea(
                  child: Body(
                    key: vm.userProfileMainKey,
                    vm: vm,
                    hasBottomBtn: widget.hasBottomBtn,
                    userLoginId: vm.userProfile.loginId,
                    refresh: () async {
                      await vm.initData(widget.loginId);
                      setState(() {});
                    },
                  ),
                ),
          floatingActionButton:
              widget.hasBottomBtn ? ChatBtn(vm: vm) : const SizedBox(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      }),
    );
  }
}
