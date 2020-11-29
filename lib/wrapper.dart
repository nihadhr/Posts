import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posts/authenticate.dart';
import 'package:posts/sign.dart';
import 'package:posts/homepage.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<FirebaseUser>(context);
    user??print('nema korisnika');

    if(user==null)return Authenticate();else{return HomePage('novo');}
  }
}
