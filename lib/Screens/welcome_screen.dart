import 'package:chat_app/Screens/login_screen.dart';
import 'package:chat_app/Screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/roundedbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static String routename = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? get controller => _controller;
  late Animation animation;
  void inistate() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(_controller as Animation<double>);
    //_controller.forward();
    _controller!.reverse(from: 1.0);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller!.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller!.forward();
      }
    });
    _controller!.addListener(() {
      setState(() {
        //print(animation.value);
      });
    });
  }

  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Get.lazyPutt(() => DataClass());
    return Scaffold(
      //backgroundColor: Color(0xFF9F9F92),
      //backgroundColor: animation.value,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9F9F2),
              Color(0xFFC9D5B5),
              Color(0xFFE3DBDB),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  //cricle avatar
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/kill.png'),
                      height: 60.0,
                      //heiht:animation.value*100,
                    ),
                  ),
                  TypewriterAnimatedTextKit(
                    //'${_controller.value.toInt()}%',

                    text: ['Flash Chat'],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),

                    //),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              // RoundedButton(
              //   color: Color(0xFFA8DADC),
              //   title: 'Log In',
              //   onPressed: () {
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (_) => LoginScreen()));
              //   },
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Material(
                  elevation: 5.0,
                  color: Color(0xFFA8DADC),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routename);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              // RoundedButton(
              //   color: Color(0xFFA8DADC),
              //   title: 'Register',
              //   onPressed: () {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => (RegistrationScreen())));
              //   },
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Material(
                  elevation: 5.0,
                  color: Color(0xFFA8DADC),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RegistrationScreen.routename);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
