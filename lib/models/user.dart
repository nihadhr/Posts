import 'package:firebase_database/firebase_database.dart';

class User{
  String uid;
  String name;
  String surname;
  String nickname;
  DatabaseReference _id;

  User({this.uid,this.name,this.surname,this.nickname});

  SetDatabaseReference(DatabaseReference dbr){_id=dbr;}
  GetDatabaseReference(){return _id;}

  Map<String,dynamic>getJson(){
    return {
      'uid': this.uid,
      'name':this.name,
      'surname':this.surname,
      'nickname':this.nickname,
    };
  }

}