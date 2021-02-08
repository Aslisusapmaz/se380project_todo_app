import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se380_project_todo_app/screens/home_screen.dart';
import 'package:se380_project_todo_app/screens/login_screen.dart';

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
    Navigator.of(context).popAndPushNamed(
        isLoggedIn ? HomeScreen.routeName : LoginScreen.routeName);
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
