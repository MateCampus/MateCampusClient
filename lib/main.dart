
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/firebase_options.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/route_generators.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'src/business_logic/constants/color_constants.dart';
import 'src/config/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // 여기에 option을 달아서 click_action을 하는듯?
  print('백그라운드 메세지 ${message.data}');
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  setupServiceLocator(); // for serviceLocator
  WidgetsFlutterBinding.ensureInitialized(); // for firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // for firebase
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler); // for firebase(background + terminated)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]); 
    timeago.setLocaleMessages('ko', timeago.KoMessages()); // for korean timeago
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
        ],
        child: MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          title: 'zamongCampus',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', ''),
            Locale('en', ''),
          ],
          theme: ThemeData(
            primarySwatch: Palette.kToDark,
            fontFamily: 'Spoqa',
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: kMainScreenBackgroundColor,
                statusBarBrightness: Brightness.light
              )
            ),
          ),
          routes: routes,
          initialRoute: "/splash",
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: NavigationService().navigationKey,
        ));
  }
}
