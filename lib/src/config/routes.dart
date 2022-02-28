import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/views/home.dart';
import 'package:zamongcampus/src/ui/views/login/login_main/login_main_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const Home(),
  "/login": (BuildContext context) => const LoginMainScreen(),
};
