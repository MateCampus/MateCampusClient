import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/init/main_service.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'src/config/routes.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // 여기에 option을 달아서 click_action을 하는듯?
  print('Handling a background message ${message.messageId}');
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
          title: 'zamongCampus',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: routes,
          initialRoute: "/splash",
        ));
  }
}
