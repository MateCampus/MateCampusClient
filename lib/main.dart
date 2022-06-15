import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zamongcampus/src/config/navigation_service.dart';
import 'package:zamongcampus/src/config/route_generators.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'src/config/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // 여기에 option을 달아서 click_action을 하는듯?
  print('백그라운드 메세지 ${message.data}');
}

Future<void> main() async {
  setupServiceLocator(); // for serviceLocator
  WidgetsFlutterBinding.ensureInitialized(); // for firebase
  await Firebase.initializeApp(); // for firebase
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler); // for firebase(background + terminated)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Spoqa'),
          routes: routes,
          initialRoute: "/splash",
          onGenerateRoute: RouteGenerator.generateRoute,
          navigatorKey: NavigationService().navigationKey,
        ));
  }
}
