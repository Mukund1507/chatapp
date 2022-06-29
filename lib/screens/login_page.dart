import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/home_page.dart';
import '/screens/registration_page.dart';
import '../widgets/roundedtextbutton.dart';
import '../widgets/roundtextfield.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/loginPage';
  LoginPage({Key? key}) : super(key: key);
  String username = '';
  String password = '';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RoundedTextField(
                onChange: (val) {
                  username = val;
                },
                onSubmit: (val) {},
                hintText: 'username',
                secureText: false,
              ),
              const SizedBox(
                height: 50,
              ),
              RoundedTextField(
                onChange: (val) {
                  password = val;
                },
                onSubmit: (val) {},
                hintText: 'password',
                secureText: true,
              ),
              const SizedBox(
                height: 100,
              ),
              RoundedTextButton(
                text: 'Log-in',
                textStyle: const TextStyle(color: Colors.black),
                color: Colors.amberAccent,
                onPress: () async {
                  try {
                    final user = await _firebaseAuth.signInWithEmailAndPassword(
                        email: '$username@gmail.com', password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, HomePage.routeName);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegistrationPage.routeName);
                },
                child: const Text(
                  'not a user?',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
