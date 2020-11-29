import 'dart:io';
import 'package:flutter/material.dart';
import 'package:posts/services/auth.dart';

class Sign extends StatefulWidget {
  final Function set;
  Sign({this.set});
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  final AuthService _authService=new AuthService();
  String email;
  String pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],
      body: Container(
          padding: EdgeInsets.all(40),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo1.png'),
           Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Email',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      email=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(autocorrect: false,
                      decoration: InputDecoration(hintText: 'Password',
                          focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                      onChanged:(value){ setState(() {
                        pass=value;
                      }); },
                      obscureText: true,cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2)
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.deepOrange[400],
                    child: Text('Sign in',style: TextStyle(color: Colors.white, letterSpacing: 2,fontWeight: FontWeight.bold)),
                    splashColor: Colors.white,
                    onPressed: ()async{
                          dynamic result=_authService.signIn(email, pass);
                    },
                  ),
                  SizedBox(height: 12.0),
                  GestureDetector(child: Text("Don't have an account? Register here"),
                    onTap: (){
                      widget.set();
                    },),

                ],
              ),

            ),

          ],
        )



      ),
    );
  }
}
