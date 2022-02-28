import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'src/business_logic/view_models/main_view_model.dart';
import 'src/config/routes.dart';
import 'src/ui/views/home.dart';

String initRoute = "/login";
Future<void> main() async {
  setupServiceLocator();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') == null) {
    initRoute = "/login";
  } else {
    initRoute = "/";
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // login말고 다른 mainviewmodel를 만들어야할듯..?

    return ChangeNotifierProvider(
        create: (BuildContext context) => MainViewModel(),
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
