import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/splash_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  SplashViewModel vm = serviceLocator<SplashViewModel>();
  String appStatus = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    vm.setImage();
    vm.splashInit(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // switch (state) {
    //   case AppLifecycleState.resumed:
    //     appStatus = "resumed";
    //     print("app 상태" + appStatus);
    //     break;
    //   case AppLifecycleState.inactive:
    //     appStatus = "inactive";
    //     print("app 상태" + appStatus);
    //     break;
    //   case AppLifecycleState.detached:
    //     appStatus = "detached";
    //     print("app 상태" + appStatus);
    //     break;
    //   case AppLifecycleState.paused:
    //     appStatus = "paused";
    //     print("app 상태" + appStatus);
    //     break;
    //   default:
    //     appStatus = "active";
    //     print("app 상태" + appStatus);
    //     break;
    // }
    vm.changeAppStatus(state);
    print('app 상태' + vm.appStatus);
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   print('remove observer');
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
      child: Consumer<SplashViewModel>(
        builder: (context, value, child) {
          return Material(
              child: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Image.asset(vm.splashImg, fit: BoxFit.cover),
          ));
        },
      ),
    );
  }
}
