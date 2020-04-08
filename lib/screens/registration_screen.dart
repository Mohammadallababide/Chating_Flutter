import 'package:flash_chat/component/RoundedButton.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFeildDocration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFeildDocration.copyWith(
                    hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Regester',
                color: Colors.blueAccent,
                onPressed: () async {
                  try {
                    final newUser = await auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    print(
                        'the email is : $email and the password is $password');
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('LogIn Error'),
                              content: Text('email or password not valuied'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OKey'),
                                ),
                              ],
                            );
                          });
                    }
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('NetWork Wrong'),
                            content: Text(
                                'Some thing Worng in the connection or your Contry is blocked '),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OKey'),
                              ),
                            ],
                          );
                        });
                  }
                },
              )
            ],
          ),
        ));
  }
}
