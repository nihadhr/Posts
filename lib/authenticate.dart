import 'package:flutter/material.dart';
import 'package:posts/register.dart';
import 'package:posts/sign.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}
class _AuthenticateState extends State<Authenticate> {
  bool toggle=true;
  void set(){
    setState(() {
      toggle= !toggle;
    });
  }
  @override
  Widget build(BuildContext context) {
    return toggle?Sign(set: this.set):Register(set:this.set);
  }
}
