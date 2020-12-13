import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:posts/models/post.dart';
import 'package:posts/models/user.dart';

class Database {

  final databaseRef = FirebaseDatabase.instance.reference();

  DatabaseReference addPost(Post post) {
    var id = databaseRef.child('posts/').push();
    id.set(post.getJson());
    return id;
  }


  DatabaseReference addUser(User user) {
    var id = databaseRef.child('users/').push();
    id.set(user.getJson());
    return id;
  }
  Future<User>getUser(String uid)async{
    DataSnapshot dataSnapshot = await databaseRef.child('users/').once();
    var user=new User();
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, values) {
        if(values['uid']==uid){
          user.name=values['name']; user.surname=values['surname'];
          user.nickname=values['nickname']; user.uid=uid;
          user.SetDatabaseReference(databaseRef.child('users/' + key));
        }
      });
    }
   return user;
  }
  Future updateUser(String uid,String name,String surname,String nickname)async{
    var user=await getUser(uid);
    var idUser=user.GetDatabaseReference();
    idUser.update(user.getJson());
  }
  Future<bool> isNicknameAvailable(String nickname)async{
    bool isAvailable=true;
    DataSnapshot dataSnapshot = await databaseRef.child('users/').once();
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, values) {
        if (values['nickname']==nickname) {
          isAvailable=false;
        }
      });
    }
    return isAvailable;
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