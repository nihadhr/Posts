import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posts/services/auth.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function set;
  Register({this.set});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _authService=new AuthService();
  String name;
  String surname;
  String nickname;
  String email;
  String pass;
  String err='';

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.purple[700],

      body: Container(

        padding: EdgeInsets.all(40),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[

              Image.asset('assets/logo1.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Name',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                        name=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Surname',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      surname=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Nickname',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      nickname=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Email',
                        focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                    onChanged:(value){ setState(() {
                      email=value;
                    });} ,
                    cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2),keyboardType:TextInputType.emailAddress,
                  ),
                  TextFormField(autocorrect: false,
                      decoration: InputDecoration(hintText: 'Password',
                          focusedBorder:UnderlineInputBorder(borderSide:BorderSide(color: Colors.orange,width:3))   ) ,
                      onChanged:(value){ setState(() {
                        pass=value;
                      }); },
                      obscureText: true,cursorColor: Colors.white,style: TextStyle(color: Colors.white,letterSpacing: 2)
                  ),
                  SizedBox(height: 20.0),
                  Text(err,style: TextStyle(color: Colors.white),),
                  SizedBox(height: 5.0),
                  RaisedButton(
                    splashColor: Colors.white,
                    color: Colors.deepOrange[400],
                    child: Text('Register',style: TextStyle(color: Colors.white, letterSpacing: 2,fontWeight: FontWeight.bold)),
                    onPressed: ()async{
                       var res= _authService.registerEmailPassword(this.email, this.pass, this.name, this.surname, this.nickname);
                       if(res == null){
                          setState(() {
                              err='Email is already used';
                          });
                        }
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
