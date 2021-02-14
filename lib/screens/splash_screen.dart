import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se380_project_todo_app/screens/home_screen.dart';
import 'package:se380_project_todo_app/screens/login_screen.dart';

import 'landing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _asyncInit();
    super.initState();
  }

  Future<void> _asyncInit() async {
    await Firebase.initializeApp();
    bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if(isLoggedIn)
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LandingScreen()));
    else
      Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
