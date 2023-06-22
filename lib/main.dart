import 'package:chat_app/Screens/chat_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/registration_screen.dart';
import 'package:chat_app/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.routename,
      routes: {
        WelcomeScreen.routename: (context) => WelcomeScreen(),
        LoginScreen.routename: (context) => LoginScreen(),
        RegistrationScreen.routename: (context) => RegistrationScreen(),
        Chat_Screen.routename: (context) => Chat_Screen(),
      },
    );
  }
}
