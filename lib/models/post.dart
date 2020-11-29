import 'package:flutter/material.dart';

class Post{
  String text;
  String author;
  int likes;
  bool userLiked;

  Post(String text,String author){this.text=text; this.author=author; likes=0; userLiked=false;}
  void userLike(){
    userLiked= !userLiked;
    if(userLiked)likes++;else likes--;
  }

}
