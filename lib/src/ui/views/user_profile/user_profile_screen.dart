import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_demand_survey_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/user_profile/components/body.dart';

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
    vm.loadUserProfile(widget.loginId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<UserProfileDemandSurveyViewModel>(
          builder: (context, vm, child) {
        return Scaffold(
          appBar: SubAppbar(
            actions: [
              IconButton(
                icon: const Icon(CupertinoIcons.ellipsis_vertical),
                color: Colors.black,
                iconSize: kAppBarIconSizeCP,
                onPressed: () {},
              )
            ],
          ),
          backgroundColor: kMainScreenBackgroundColor,
          body: vm.busy
              ? const IsLoading()
              : Body(vm: vm, hasBottomBtn: widget.hasBottomBtn),
        );
      }),
    );
  }
}
