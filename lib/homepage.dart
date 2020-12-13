import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:posts/services/auth.dart';
import 'package:posts/services/database.dart';
import 'package:posts/usersettings.dart';
import 'models/post.dart';
import 'textinput.dart';
import 'postlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final FirebaseUser user;
  HomePage(this.user);

}

class _HomePageState extends State<HomePage> {
  final database=new Database();
  void addPost(String text){
    var post=new Post(text,widget.user.displayName);
    post.setId(database.addPost(post));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService=new AuthService();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home'),backgroundColor: Colors.deepOrange,
        actions: <Widget>[

          IconButton(icon:Icon(Icons.logout,color: Colors.white,), onPressed:()async{ await _authService.signOut();},),
          IconButton(icon:Icon(Icons.settings,color: Colors.white,),
              onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserSettings(widget.user.uid)));
              })
        ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: PostList(widget.user)) ,
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextInputWidget(addPost)),
          ],
        ),


      ),

    );
  }
}
