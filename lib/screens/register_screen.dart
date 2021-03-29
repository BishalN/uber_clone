import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/screens/mainscreen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  static const screenName = 'register';
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              'Register as a rider',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Bolt',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: widget.nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: widget.emailTextEditingController,
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
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: widget.phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 14),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  TextField(
                    controller: widget.passwordTextEditingController,
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
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () => {
                      if (widget.nameTextEditingController.text.length < 4)
                        {
                          displayToastMessage(
                              "name must be atleast 5 characters long.",
                              context)
                        }
                      else if (!widget.emailTextEditingController.text
                          .contains('@'))
                        {
                          displayToastMessage(
                              "enter a valid email address", context)
                        }
                      else if (widget.phoneTextEditingController.text.isEmpty)
                        {
                          displayToastMessage(
                              "phone number is required", context)
                        }
                      else if (widget
                              .passwordTextEditingController.text.length <
                          7)
                        {
                          displayToastMessage(
                              "password must be atleast 7 characters long.",
                              context)
                        }
                      else
                        {registerNewUser(context)}
                    },
                    color: Colors.yellow,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      width: 250,
                      child: Center(
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Bolt',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.screenName, (route) => false)
              },
              child: Text(
                'Already have an account ? Login here.',
              ),
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: widget.emailTextEditingController.text,
              password: widget.passwordTextEditingController.text);

      if (userCredential != null) {
        Map _userDataMap = {
          "name": widget.nameTextEditingController.text.trim(),
          "email": widget.emailTextEditingController.text.trim(),
          "phone": widget.phoneTextEditingController.text.trim()
        };
        useRef.child(userCredential.user.uid).set(_userDataMap);
        displayToastMessage('Account created successfully', context);

        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.screenName, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayToastMessage('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        displayToastMessage(
            'The account already exists for that email.', context);
      }
    } catch (e) {
      displayToastMessage(e.toString(), context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    print('object');
    Fluttertoast.showToast(msg: message, textColor: Colors.black);
  }
}
