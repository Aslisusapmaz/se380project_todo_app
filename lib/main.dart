import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'models/authentication.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication(),
        )
      ],
      child:MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: LoginScreen(),
       routes: {
         SignupScreen.routeName:(context)=>SignupScreen(),
         LoginScreen.routeName:(context)=>LoginScreen(),
         HomeScreen.routeName:(context)=>HomeScreen(),
       },
      )
    );
  }
}


