import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              'Login as rider',
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
                  TextField(
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
                    onPressed: () => {print('Login button clicked')},
                    color: Colors.yellow,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      width: 150,
                      child: Center(
                        child: Text(
                          'Login',
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
            FlatButton(
              onPressed: () => {},
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
