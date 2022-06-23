import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class VoiceMainScreen extends StatefulWidget {
  const VoiceMainScreen({Key? key}) : super(key: key);

  @override
  State<VoiceMainScreen> createState() => _VoiceMainScreenState();
}

class _VoiceMainScreenState extends State<VoiceMainScreen> {
  VoiceMainScreenViewModel vm = serviceLocator<VoiceMainScreenViewModel>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      vm.initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
        value: vm,
        child:
            Consumer<VoiceMainScreenViewModel>(builder: (context, vm, child) {
          return Scaffold(
              appBar: AppBar(
                  title: SvgPicture.asset('assets/images/svg/appbarLogo.svg'),
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  centerTitle: false,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.bell),
                      iconSize: kAppBarIconSizeFA,
                    )
                  ],
                  backgroundColor: kMainColor,
                  elevation: 0.0),
              backgroundColor: kMainScreenBackgroundColor,
              body: Body(vm: vm));
        }));
  }
}
