import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const screenName = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Uber',
          style: TextStyle(letterSpacing: 10, fontFamily: 'Bolt'),
        ),
      ),
    );
  }
}
