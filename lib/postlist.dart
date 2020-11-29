import 'package:flutter/material.dart';
import 'models/post.dart';

class PostList extends StatefulWidget {
  final List<Post>list;
  PostList(this.list);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Post p){
    setState(() {
      p.userLike();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context,index){
        var post=widget.list[index];

        return Card(
          child:Row(
            children: <Widget>[
              Expanded(child:
              ListTile(title: Text(post.text),subtitle: Text(post.author),)

              ),
              Row(children: <Widget>[
                Text(post.likes.toString()),
                IconButton(
                  icon:Icon(Icons.thumb_up,color:post.userLiked?Colors.black:Colors.grey,),
                  onPressed:(){
                    like(post);
                  },

                ),
              ])

            ],
          ),
        );
      },
    );
  }
}

