import 'package:firebase_database/firebase_database.dart';
import 'package:posts/models/post.dart';

class Database {

  final databaseRef = FirebaseDatabase.instance.reference();

  DatabaseReference addPost(Post post) {
    var id = databaseRef.child('posts/').push();
    id.set(post.getJson());
    return id;
  }

  Future updatePost(Post p) async{
    p.getDatabaseReference().update(p.getJson());
  }

  Stream<dynamic> getP(){
    return databaseRef.child('posts/').onValue;
  }

   Future<List<Post>> getPosts() async {
    DataSnapshot dataSnapshot = await databaseRef.child('posts/').once();
    List<Post>lista = [];
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, values) {
        Post novi = new Post(
            values['text'] ?? 'Empty', values['author'] ?? 'Unknown');
        novi.setId(databaseRef.child('posts/' + key));
        if (values['usersLiked'] != null) {
          novi.usersLiked = values['usersLiked'].toSet();
        }
        lista.add(novi);
      });
    }
    return lista;
  }



}