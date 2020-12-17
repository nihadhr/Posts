import 'dart:io';
import 'package:flutter/material.dart';
import 'package:posts/loading.dart';
import 'package:posts/resetpassword.dart';
import 'package:posts/services/auth.dart';

class Sign extends StatefulWidget {
  final Function set;
  Sign({this.set});

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  final AuthService _authService=new AuthService();
  final _formKey=new GlobalKey<FormState>();
  String email;
  String pass;
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.purple[700],
      body: Container(
          padding: EdgeInsets.all(40),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo1.png'),
           Form(
             key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'This field is required' : null,
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
                      validator: (val) => val.isEmpty ? 'This field is required' : null,
                      decoration: InputDecoration(hintText: 'Password',
                          focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                      onChanged:(value){ setState(() {
                        pass=value;
                      }); },
                      obscureText: true,cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2)
                  ),
                  SizedBox(height: 10.0),
                  Text(error,style: TextStyle(color: Colors.white),),
                  SizedBox(height: 12.0),
                  RaisedButton(
                    color: Colors.deepOrange[400],
                    child: Text('Sign in',style: TextStyle(color: Colors.white, letterSpacing: 2,fontWeight: FontWeight.bold)),
                    splashColor: Colors.white,
                    onPressed: ()async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.signIn(email, pass);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Email or password wrong';
                          });
                        }
                      }else{ setState(() {error='';});   }
                    },
                  ),
                  SizedBox(height: 12.0),
                  GestureDetector(child: Text("Forgot my password"),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ResetPassword() ));
                    },),
                  SizedBox(height: 4.0),
                  GestureDetector(child: Text("Don't have an account ? Register here"),
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
