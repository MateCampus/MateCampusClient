import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/init.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splashInit(context);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset("assets/images/splash/splash1.png"),
          )
        ],
      ),
    );
  }

  Future<void> splashInit(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    String firstRoute = await Init.initialize();
    print(firstRoute + " 로 이동!");
    if (firstRoute == "/" || firstRoute == "/login") {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(firstRoute, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/error", (Route<dynamic> route) => false);
    }
  }
}
