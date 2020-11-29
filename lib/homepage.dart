import 'package:flutter/material.dart';
import 'package:posts/services/auth.dart';
import 'models/post.dart';
import 'textinput.dart';
import 'postlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final String name;
  HomePage(this.name);

}

class _HomePageState extends State<HomePage> {
  List<Post>posts=new List<Post>();

  void addPost(String text){
    setState(() {
      posts.add(new Post(text,widget.name));
    });}

  @override
  Widget build(BuildContext context) {
    final AuthService _authService=new AuthService();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home'),backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(icon:Icon(Icons.logout,color: Colors.white,), onPressed:()async{ await _authService.signOut();})
        ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: PostList(posts)) ,
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextInputWidget(addPost)),
          ],
        ),


      ),

    );
  }
}
