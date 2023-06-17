import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/roundedbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this, upperBound: 1);
    animation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 100,
                    child: Image.asset("images/logos.png"),
                  ),
                ),

                SizedBox(
                  height: 40,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        TypewriterAnimatedText('Flash chat'),
                      ],
                    ),
                  ),
                ),


        ],
      ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton( color: Colors.blueAccent, title: 'Log In', id: LoginScreen.id,),
            const SizedBox(
              height: 8.0,
            ),
           RoundedButton(

            color: Colors.blue, title: 'Register', id: RegistrationScreen.id, )
          ],
        ),

      ),

    );
  }
}

