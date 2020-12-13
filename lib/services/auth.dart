import 'package:firebase_auth/firebase_auth.dart';
import 'package:posts/models/user.dart';
import 'package:posts/services/database.dart';

class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Database database=new Database();

  Future registerEmailPassword(String email, String pass, String name,
      String surname, String nickname) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      UserUpdateInfo update=new UserUpdateInfo(); update.displayName=nickname;
      result.user.updateProfile(update);
      database.addUser(new User(uid:result.user.uid,name:name,surname:surname,nickname:nickname));
      result.user.sendEmailVerification();
      return result.user;
    }
    catch (err) {
      if(err.toString().contains('INVALID')){return 'The email address is badly formatted';}
      else if(err.toString().contains('ALREADY')){return 'The email address is already in use by another account';}
      return 'The password must be 6 characters long or more';
    }
  }

  Future signIn(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      return result.user;
    }
    catch (err) {
      return null;
    }

  }

  Future signOut() async {
    _auth.signOut();
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }
}