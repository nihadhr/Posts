import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:posts/authenticate.dart';
import 'package:posts/sign.dart';
import 'package:posts/homepage.dart';
import 'package:posts/verify.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null){return Authenticate();}
    else if(user.isEmailVerified){return HomePage(user);}
    else {return Verify();}
    }
}



