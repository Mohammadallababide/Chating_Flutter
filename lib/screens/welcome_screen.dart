import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

//  todo 14:31 vedio 6
class WelcomeScreen extends StatefulWidget {
  static String id = 'welcom_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  initState() {
    super.initState();
    // create the AnimationController object and put his prperotiy
    controller = AnimationController(
      // the peruid of the animation
      duration: Duration(seconds: 3),
      // note where we use curvedAnimtion to decide type of animtion we must not use upperBound in the Controller
      // upperBound: 100.0,
      vsync: this,
    );
    // decide the type behavior of the change
    // code ...
    // animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    // end code ...

    // another type of the animation is ColorTween and we use .animate to return animtion
    animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);

    // the direction of the animation
    controller.forward();
    // addStatusListener use to do action when change the state of the controller
    // code ...
    controller.addStatusListener((status) {
    // this condtion to make the animation do in the infnti loop ......
    // here for status == AnimationStatus.completed referse to done the Controller.forward
    // code ...
    // if (status == AnimationStatus.completed) {
    //   controller.reverse(from: 1.0);
    // }
    // end code ...
    // here for status == AnimationStatus.dismissed referse to done the Controller.reverse
    // code ...
    // else if (status == AnimationStatus.dismissed) {
    //   controller.forward();
    // }
    // end code ...
      print(status);
    });
    // end code ...
    // the listener of the action in the animation
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    // we need dispose to dispose controller when we dispose the screen for keep resourse like memory
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          // Colors.white,
          animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    // here we use controller value to change the size of the logo with the chinging of the value of the controller
                    //  here we manpulate with 100 becouse we not use upperBound when we use CurvedAnimation
                    height:
                        // animation.value * 100,
                        60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
