import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Post{
  String text;
  String author;
  Set usersLiked={};
  DatabaseReference _id;


  Post(String text,String author){this.text=text; this.author=author;}

  Future userLike(FirebaseUser user)async{
   if(usersLiked.contains(user.uid)){usersLiked.remove(user.uid);}else{usersLiked.add(user.uid);}
  }

  void setId(DatabaseReference id){_id=id;}
  DatabaseReference getDatabaseReference(){return _id;}

  Map<String,dynamic>getJson(){
    return {
      'text':this.text,
      'author':this.author,
      'usersLiked':this.usersLiked.toList()
    };
  }

}
