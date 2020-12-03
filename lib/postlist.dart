import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:posts/loading.dart';
import 'package:posts/services/database.dart';
import 'package:posts/services/postsApiService.dart';
import 'models/post.dart';

class PostList extends StatefulWidget {
  final FirebaseUser user;
  PostList(this.user);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  Database database = new Database();
  List<Post>lista;
  DatabaseReference _PostsReference;
  PostsApiService _apiService;

  void like(Post p) {
    setState(() {
      p.userLike(widget.user);
      database.updatePost(p);
    });
  }
  List<Post>transform(DataSnapshot dataSnapshot){
    List<Post>lista=[];
    dataSnapshot.value.forEach((key, values) {
      Post novi = new Post(
          values['text'] ?? 'Empty', values['author'] ?? 'Unknown');
      novi.setId(_apiService.getDatabaseReference().child('posts/' + key));
      if (values['usersLiked'] != null) {
        novi.usersLiked = values['usersLiked'].toSet();
      }
      lista.add(novi);
    });

    return lista;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiService=new PostsApiService();
    _PostsReference=_apiService.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _PostsReference.onValue,
      builder: (context,snap){
          if(snap.hasData){
            DataSnapshot snapshot=snap.data.snapshot;
            lista=transform(snapshot);
            return ListView.builder(
               itemCount: lista.length,
              itemBuilder: (context,index){
              var post=lista[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Expanded(child:
                      ListTile(title: Text(post.text), subtitle: Text(post.author),)

                      ),
                      Row(children: <Widget>[
                        Text(post.usersLiked.length.toString()),
                        IconButton(
                          icon: Icon(Icons.thumb_up),
                          // ,color:post.userLiked?Colors.black:Colors.grey,
                          onPressed: ()async {
                              await post.userLike(widget.user);
                              await database.updatePost(post);
                          },

                        ),
                      ])

                    ],
                  ),
                );
              },
            );
          }
          else{
            return Loading();
          }

      },
    );




  }
}

// class Nesto extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//     itemCount: widget.list.length,
//     itemBuilder: (context, index) {
//       var post = widget.list[index];
//       return Card(
//         child: Row(
//           children: <Widget>[
//             Expanded(child:
//             ListTile(title: Text(post.text), subtitle: Text(post.author),)
//
//             ),
//             Row(children: <Widget>[
//               Text(post.usersLiked.length.toString()),
//               IconButton(
//                 icon: Icon(Icons.thumb_up),
//                 // ,color:post.userLiked?Colors.black:Colors.grey,
//                 onPressed: () {
//                   like(post);
//                 },
//
//               ),
//             ])
//
//           ],
//         ),
//       );
//     },
//     );
//
//   }
// }
