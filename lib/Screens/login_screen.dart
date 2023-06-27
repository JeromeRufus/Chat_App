import 'package:chat_app/components/roundedbutton.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String routename = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/images/kill.png'),
                height: 200,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (Value) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedButton(
                color: Color(0xFFEAFFFD), title: 'Log In', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
