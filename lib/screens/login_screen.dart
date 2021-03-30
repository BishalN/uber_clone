import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/screens/mainscreen.dart';
import 'package:uber_clone/screens/register_screen.dart';
import 'package:uber_clone/widgets/dialog.dart';

import './register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const screenName = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = TextEditingController();
  TextEditingController _password = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  displayToastMessage(String message, BuildContext context) {
    print('object');
    Fluttertoast.showToast(msg: message);
  }

  void loginUser(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Logging you in')));

      try {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ProgressDialog(message: 'Authenticating! please wait....');
            });
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
                email: _emailAddress.text, password: _password.text);

        if (userCredential.user != null) {
          Navigator.pop(context);
          displayToastMessage('Logged in successfully', context);

          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.screenName, (route) => false);
        }
      } catch (e) {
        Navigator.pop(context);

        displayToastMessage(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 45),
            Image(
                alignment: Alignment.center,
                image: AssetImage('assets/images/logo.png'),
                width: 390,
                height: 300,
                fit: BoxFit.cover),
            SizedBox(
              height: 1,
            ),
            Text(
              'Login as a rider',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Bolt',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter an email address";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailAddress,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        } else {
                          return null;
                        }
                      },
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loginUser(context);
                      },
                      child: Text('Login'),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterScreen.screenName, (route) => false)
              },
              child: Text(
                'Don\'t have an account ? Register here.',
              ),
            )
          ],
        ),
      ),
    );
  }
}
