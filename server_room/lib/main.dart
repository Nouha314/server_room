import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:server_room/auth/login.dart';
import 'package:server_room/home_page.dart';
import 'package:server_room/auth/register.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized(); //don't touch
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Server Room',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'home': (context) => const MyHomePage(),
        }),
  );
}
