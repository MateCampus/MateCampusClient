import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/init.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/signup_bottom_sheet_component/signup_bottom_sheet.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    splashInit(context);
    return Material(
      child: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Image.asset(
          'assets/images/splash/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> splashInit(BuildContext context) async {
    // await Future.delayed(const Duration(milliseconds: 1000));
    String firstRoute = await Init.initialize();
    print(firstRoute + " 로 이동!");
    if (firstRoute == "/") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(firstRoute, (Route<dynamic> route) => false);
    } else if (firstRoute == "/login") {
      showCustomModalBottomSheet(context, SignUpBottomSheet(), false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/error", (Route<dynamic> route) => false);
    }

//원래코드
// await Future.delayed(const Duration(milliseconds: 1000));
//     String firstRoute = await Init.initialize();
//     print(firstRoute + " 로 이동!");
//     if (firstRoute == "/" || firstRoute == "/login") {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(firstRoute, (Route<dynamic> route) => false);
//     } else {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil("/error", (Route<dynamic> route) => false);
//     }
  }
}
