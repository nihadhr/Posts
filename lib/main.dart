import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posts/register.dart';
import 'package:posts/services/auth.dart';
import 'package:posts/sign.dart';
import 'package:posts/wrapper.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'package:posts/login.dart';
import 'models/post.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: <String, WidgetBuilder> {
          '/register': (BuildContext context) => new Register(),
          '/sign': (BuildContext context) => new Sign(),
          '/wrapper': (BuildContext context) => new Wrapper(),
        },
      ),
    );
  }
}


