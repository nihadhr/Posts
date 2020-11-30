import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posts/loading.dart';
import 'package:posts/services/auth.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function set;
  Register({this.set});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey=new GlobalKey<FormState>();
  final _authService=new AuthService();
  String name;
  String surname;
  String nickname;
  String email;
  String pass;
  String error='';
  bool loading=false;
  @override
  Widget build(BuildContext context) {
   return loading?Loading():Scaffold(
      backgroundColor: Colors.purple[700],

      body: Container(

        padding: EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[

              Image.asset('assets/logo1.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  TextFormField(
                    validator: (val) => val.isEmpty ? 'This field is required' : null,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Name',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                        name=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'This field is required' : null,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Surname',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      surname=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'This field is required' : null,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Nickname',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      nickname=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
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
                    splashColor: Colors.white,
                    color: Colors.deepOrange[400],
                    child: Text('Register',style: TextStyle(color: Colors.white, letterSpacing: 2,fontWeight: FontWeight.bold)),
                    onPressed: ()async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic res = await _authService.registerEmailPassword(
                            this.email, this.pass, this.name, this.surname, this
                            .nickname);
                        if (res.runtimeType == String) {
                          setState(() {
                            loading = false;
                            error = res;
                          });
                        }
                      }
                      else{ setState(() {error='';});   }
                    },
                  ),
                  SizedBox(height: 12.0),
                  GestureDetector(child: Text("Already have an account? Sign in"),
                    onTap: (){
                      widget.set();
                    },),

                ],
              ),
            ],

          ),

        ),



      ),
    );
  }
}
