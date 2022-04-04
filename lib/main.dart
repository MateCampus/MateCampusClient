import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'src/business_logic/auth/auth_service.dart';
import 'src/config/routes.dart';

String initRoute = "/login";
Future<void> main() async {
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') == null || prefs.getString('loginId') == null) {
    initRoute = "/login";
  } else {
    // 서버 통신 후 token이 실제로 맞는지 확인까지 하고 이동?
    bool isTokenValid = true;
    if (isTokenValid) {
      AuthService authService = serviceLocator<AuthService>();
      authService.authInit(
          token: prefs.getString('token')!,
          loginId: prefs.getString('loginId')!);
      initRoute = "/";
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // authservice와 더불어, chatservice도 필요할 듯.
        // 그러면 chatservice에서의 chatroom들을 관리할 수 있다.
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => AuthService()),
        ],
        child: MaterialApp(
          title: 'zamongCampus',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
          initialRoute: initRoute,
        ));
  }
}
