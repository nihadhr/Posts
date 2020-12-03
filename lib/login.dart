// import 'package:flutter/material.dart';
// import 'package:posts/textinput.dart';
//
// import 'homepage.dart';
//
// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login'),),
//       body: Body(),
//     );
//   }
// }
//
// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   String name;
//   TextEditingController controller=new TextEditingController();
//   void click(){
//     this.name=controller.text;
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(this.name)));
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Align( alignment: Alignment.topCenter,
//       child:Padding(
//         padding: EdgeInsets.fromLTRB(0,20,0,20),
//         child: TextField(
//           controller: this.controller,
//           decoration:InputDecoration(
//             prefixIcon: Icon(Icons.person),labelText:'Type your name',
//             suffixIcon:IconButton(icon:Icon(Icons.check),tooltip: 'Enter',
//                 onPressed:this.click
//                 ),
//
//           ),
//           autocorrect: false,
//         ),
//       )
//     );
//   }
// }
//
//
