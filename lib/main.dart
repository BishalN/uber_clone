import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/screens/login_screen.dart';
import 'package:uber_clone/screens/register_screen.dart';

import 'screens/mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference useRef = FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.screenName,
      routes: {
        RegisterScreen.screenName: (context) => RegisterScreen(),
        LoginScreen.screenName: (context) => LoginScreen(),
        MainScreen.screenName: (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
